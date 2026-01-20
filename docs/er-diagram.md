# ER Diagram

```mermaid
erDiagram
    direction LR
    user_answers ||--|{ prompt_topics : "has: 1..N"
    user_answers ||--|| writing_answer_details : "has: 1..1"
    user_answers ||--|| speaking_answer_details : "has: 1..1"
    user_answers ||--|{ speaking_conversation_histories : "has: 1..N"

    user_answers {
        INTEGER id PK
        TEXT test_task
        TEXT created_at
    }

    prompt_topics {
        INTEGER id PK
        INTEGER user_answer_id FK
        INT order
        TEXT title 
    }

    writing_answer_details {
        INTEGER id PK
        INTEGER user_answer_id FK
        INT prompt_type
        TEXT prompt_text
        TEXT answer_text
        INT duration
        REAL score
        REAL achievement_score
        REAL coherence_score
        REAL lexial_score
        REAL grammatical_score
        INT isGraded
        INT feedback
        TEXT updatedAt
    }

    speaking_answer_details {
        INTEGER id PK
        INTEGER user_answer_id FK
        INT duration
        REAL score
        REAL coherence_score
        REAL lexial_score
        REAL grammatical_score
        REAL fluency_score
        INT isGraded
        INT feedback
        TEXT updatedAt
    }

    speaking_conversation_histories {
        INTEGER id PK
        INTEGER user_answer_id FK
        int order
        int role
        TEXT text
        REAL fluency_score
        INTEGER created_at
    }
```