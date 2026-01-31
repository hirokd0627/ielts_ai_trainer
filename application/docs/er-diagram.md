# ER Diagram

```mermaid
erDiagram
    direction LR
    user_answers ||--|{ prompt_topics : "has: 1..N"
    user_answers ||--|| writing_answer_details : "has: 1..1"
    user_answers ||--|| speaking_answer_details : "has: 1..1"
    user_answers ||--|{ speaking_utterances : "has: 1..N"

    user_answers {
        INTEGER id PK
        TEXT test_task
        TEXT created_at
    }

    prompt_topics {
        INTEGER user_answer_id PK,FK
        INTEGER order PK
        TEXT title 
    }

    writing_answer_details {
        INTEGER id PK
        INTEGER user_answer_id FK
        TEXT prompt_type
        TEXT prompt_text
        TEXT answer_text
        INTEGER duration
        REAL score
        REAL achievement_score
        REAL coherence_score
        REAL lexial_score
        REAL grammatical_score
        INTEGER is_graded
        TEXT feedback
        TEXT updated_at
    }

    speaking_answer_details {
        INTEGER id PK
        INTEGER user_answer_id FK
        INTEGER duration
        REAL score
        REAL coherence_score
        REAL lexial_score
        REAL grammatical_score
        REAL fluency_score
        INTEGER isGraded
        TEXT feedback
        TEXT note
        TEXT updated_at
    }

    speaking_utterances {
        INTEGER user_answer_id PK,FK
        INTEGER order PK
        INTEGER is_user
        TEXT message
        REAL fluency_score
        TEXT updated_at
    }
```