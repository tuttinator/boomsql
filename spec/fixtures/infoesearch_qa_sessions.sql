SELECT  recording.RecordingID, 
  recording.DateCreated, 
  recording.Name, 
  recording.Duration, 
  rec_state.Name AS State, 
  recording.FileName,
  session.Text,
  session.DateStarted,
  session.DateSubmitted,
  users.UserName, 
  workhubusers.ID 
FROM Recordings as recording
INNER JOIN Sessions AS session ON
  recording.RecordingID = session.RecordingID
INNER JOIN RecStates AS rec_state ON
  recording.StatusID = rec_state.StatusID
INNER JOIN WorkHubUsers AS workhubusers ON 
  workhubusers.ID = session.QAID
INNER JOIN Users AS users ON
  users.UserId = workhubusers.UserID

WHERE users.UserName LIKE '%@infoesearch.com'
