module Boomsql
  
  class DatabaseProxy

    # TODO: Check if the credentials sign in to SSH okay (in a valid? method)
    # TODO: Check that the boomsql binary is available on the remote machine (in a bootstrap method)

    attr_reader :ssh_credentials

    def initialize(ssh_credentials)
      # TODO: Test if these credentials work, and raise an error if they don't
      @ssh_credentials = [  ssh_credentials[:host],
                            ssh_credentials[:username] ]

      @ssh_credentials << { port:  ssh_credentials[:port] }  unless ssh_credentials[:port].nil?
    end

    def execute(sql)
      sql_file = upload_file_contents(query: sql, md5_hash: hexdigest(sql))
      result = execute_remote_query sql_file
    end


    def upload_file_contents(sql)
      filename = "/home/boom/boomsql/#{sql[:md5_hash]}.sql"
      Net::SFTP.start(*@ssh_credentials) do |sftp|
        # Check to see if file exists
        sftp.stat filename do |response|
          # if the sql has been run before, don't bother to upload it again
          unless response.ok?
            # upload the file
            sftp.file.open(filename, "w") do |f|
              # write the contents of the query to the sql file
              f.puts sql[:query]
            end
          end
        end
      end
      filename
    end

    private

    def hexdigest(sql_string)
      Digest::MD5.hexdigest sql_string
    end

    def execute_remote_query(sql_file)
      result = nil
      Net::SSH.start(*@ssh_credentials) do |ssh|
        # Result will be serialized to YAML in output
        result = ssh.exec!("sourcervm use 2.0.0@global; boomsql #{sql_file}")
      end
      # Deserialize into a Ruby object
      # result
      YAML::load result unless result.nil?
    end


  end

end