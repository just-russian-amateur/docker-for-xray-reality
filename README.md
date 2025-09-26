# Quick Deployment of Xray/Reality on a Server

This repository is designed for fast and easy deployment of **Xray/Reality** on a server. The entire installation and configuration process on a bare server is automated, requiring only a single command in the terminal.

---

## What’s inside

- **Dependency installation**: minimal tooling, including `curl`.
- **Docker container creation and configuration**: automatic setup of the environment for Reality.
- **Automated Reality protocol configuration**: auto-generation of `config.json`, plus emission of keys, passwords, and identifiers for client configuration in the terminal.
- **Domain and port binding**: configured for the **VK.com** domain and port **443**, but you can replace these with any other ports available in your country if desired.

---

## Prerequisites

- `curl` (installable, for example, via)

```bash
sudo apt update
sudo apt install -y curl
```

> Note: Some systems may require `sudo`.

---

## Quick Installation

1. Run the following command in the terminal. It will download and execute the installer:

```bash
curl -fsSL https://raw.githubusercontent.com/Alexxxander-Laptev/docker-for-xray-reality/refs/heads/main/install.sh | bash
```

2. Depending on your network speed, installation may take from a few minutes up to ~10 minutes. Upon completion, you will see a notification of successful installation, along with:
   - the public key,
   - the UUID,
   - a shortID for subsequent client configuration.

> Recommendation: connect to the server via SSH to make it easier to copy and transfer these parameters.

---

## What you’ll see after installation

- A success message in the terminal.
- Client configuration parameters: public key, UUID, shortID.

---

## Configuration and tunable parameters

- **Default domain and port**: VK.com on port 443.
- You can replace the domain and port with values suitable for your region and environment.

---

## Key files and components

- `config.json` — the Reality configuration file (generated automatically).
- In the terminal, you’ll see client parameters:
  - public key
  - UUID
  - shortID

---

## Security and best practices

- Store keys and UUID securely.
- Regularly update dependencies and monitor Docker image updates.
- When using a public server, restrict SSH access and close unnecessary ports.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
