;; message-board-contract

;; Data variable to store the total number of messages
(define-data-var message-count uint u0)

;; Data map to store messages
(define-map messages uint {sender: principal, content: (string-utf8 500)})

;; Public function to add a new message with validation
(define-public (add-message (content (string-utf8 500)))
    (begin
        ;; Check that content is not empty
        (asserts! (> (len content) u0) (err u1))
        ;; Check that content is not too short
        (asserts! (< (len content) u500) (err u2))
        
        (let
            (
                (current-count (var-get message-count))
                (new-count (+ current-count u1))
            )
            ;; Store the message
            (map-set messages current-count {sender: tx-sender, content: content})
            ;; Increment the message count
            (var-set message-count new-count)
            ;; Return success
            (ok "Message added successfully")
        )
    )
)

;; Read-only function to get a message by ID
(define-read-only (get-message (id uint))
    (map-get? messages id)
)

;; Read-only function to get total message count
(define-read-only (get-message-count)
    (var-get message-count)
)