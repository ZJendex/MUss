
```mermaid
erDiagram 
    Event {
        int eventId PK
        int courseID FK "nullable"
				int task FK "nullable"
				int duration "nullable"
				dateTime from
				dateTime to "nullable"
    }
		RunningEvent{
			int runningEventId PK "only use id 1"
			int eventId FK "nullable"
		}
		Course {
			int courseID PK
			text courseName
		}
    Task {
        int taskId PK
				int courseId FK "nullable"
        text description
    }
		%%{an Event contains one or more tasks, and a Task is part of one and only one Event}%%
		Event |o--|{ Task: "" 
		Course |o-- o{ Event: ""
		Course |o-- o{ Task: ""
		RunningEvent ||--o| Event: ""
```