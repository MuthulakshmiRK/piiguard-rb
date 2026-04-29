# PIIGuard

Protect your logs from leaking sensitive data.

PIIGuard automatically masks personally identifiable information (PII) such as emails and phone numbers in logs and application data.

---

## 🚨 Problem

Sensitive data often leaks into logs:

```ruby
Rails.logger.info("User email is test@gmail.com")
```

Logs may contain:

* Emails
* Phone numbers
* Tokens
* API keys

This creates security and compliance risks (GDPR, etc.).

---

## ✅ Solution

PIIGuard masks sensitive data automatically:

```ruby
Rails.logger.info("User email is test@gmail.com")
```

Becomes:

```
User email is [EMAIL]
```

---

## ✨ Features

* 🔒 Masks emails and phone numbers
* 🧠 Works with strings, hashes, and arrays
* ⚡ Automatically integrates with Rails logging
* 🛠 Extensible for custom patterns
* 🧩 Lightweight and easy to use

---

## 📦 Installation

Add this line to your application's Gemfile:

```ruby
gem 'piiguard'
```

Then execute:

```bash
bundle install
```

---

## 🚀 Usage

### Basic masking

```ruby
Piiguard.mask("Contact me at test@gmail.com")
# => "Contact me at [EMAIL]"
```

### Mask structured data

```ruby
data = {
  email: "test@gmail.com",
  phone: "9876543210"
}

Piiguard.mask(data)
# => { email: "[EMAIL]", phone: "[PHONE]" }
```

---

## 🔧 Rails Integration (Automatic)

PIIGuard integrates with Rails automatically:

* Adds sensitive keys to `filter_parameters`
* Masks log messages before they are written

No additional setup required.

---

## ⚙️ Configuration

```ruby
Piiguard.configure do |config|
  config.mask_email = true
  config.mask_phone = true
end
```

Disable masking:

```ruby
Piiguard.enabled = false
```

---

## 🧪 Example

Before:

```
Started POST "/users" with params:
{ "email": "test@gmail.com" }
```

After:

```
Started POST "/users" with params:
{ "email": "[EMAIL]" }
```

---

## ⚠️ Limitations

* Uses regex-based masking (may not cover all edge cases)
* Designed for application-level protection, not full compliance guarantees

---

## 🛣 Roadmap

* Custom pattern configuration
* JSON log masking improvements
* API integration for centralized control
* Analytics and tracking

---

## 🤝 Contributing

Contributions are welcome! Feel free to open issues or submit pull requests.

---

## 📄 License

MIT License
