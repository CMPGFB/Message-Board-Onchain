# Message Board Smart Contract
For the University of Greenwich

A simple decentralized message board built on the Stacks blockchain using Clarity. This contract allows users to post messages that are permanently stored on the blockchain.

## Features

- Post messages up to 500 characters long
- View messages by ID
- Get total message count
- Input validation
- Message sender tracking

## Contract Functions

### Write Functions

#### `add-message`
Posts a new message to the board.

```clarity
(add-message (content (string-utf8 500)))
```

**Parameters:**
- `content`: The message text (max 500 characters)

**Returns:**
- `(ok "Message added successfully")` on success
- `(err u1)` if content is empty
- `(err u2)` if content exceeds 500 characters

### Read Functions

#### `get-message`
Retrieves a specific message by its ID.

```clarity
(get-message (id uint))
```

**Parameters:**
- `id`: The numeric ID of the message

**Returns:**
- Message data containing sender and content if found
- `none` if message doesn't exist

#### `get-message-count`
Returns the total number of messages posted.

```clarity
(get-message-count)
```

**Returns:**
- Total number of messages (uint)

## Data Storage

Messages are stored in a data map with the following structure:
```clarity
{
    sender: principal,  // Address of message sender
    content: string-utf8  // Message content
}
```

## Error Codes

- `u1`: Message content is empty
- `u2`: Message content exceeds maximum length (500 characters)

## Usage Example

```clarity
;; Post a message
(contract-call? .message-board-contract add-message "Hello, Stacks!")

;; Read the first message
(contract-call? .message-board-contract get-message u0)

;; Get total message count
(contract-call? .message-board-contract get-message-count)
```

## Development

### Prerequisites
- [Clarinet](https://github.com/hirosystems/clarinet)
- [Stacks Wallet](https://www.hiro.so/wallet)
- STX tokens for contract deployment and interaction

### Deployment
1. Save the contract as `message-board-contract.clar`
2. Deploy using Clarinet or the Stacks Web Wallet
3. Ensure you have enough STX for deployment fees

## Security Considerations

- All messages are public and permanently stored on the blockchain
- Message content is validated for length constraints
- Sender addresses are automatically recorded and cannot be spoofed
