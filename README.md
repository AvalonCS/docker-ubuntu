# Pelican / Pterodactyl Ubuntu Runner (Root)

Minimal Docker base image for **Pelican / Pterodactyl**, built on **Ubuntu 24.04** and designed to **run as root**.

This image is intended to be published from an **organization repository** to **GitHub Container Registry (GHCR)** and used as a base runner for game servers and similar workloads.

---

## Features

- Ubuntu 24.04 LTS
- Runs **as root** (no `container` user created)
- Compatible with Pelican / Pterodactyl `STARTUP` variable logic
- Uses `tini` as PID 1 for clean shutdowns
- Keeps `/home/container` for panel compatibility

---

## Entrypoint

The container uses a simple `entrypoint.sh` that:

- Sets `/home/container` as the working directory
- Detects and exports the internal container IP as `INTERNAL_IP`
- Converts `{{VARIABLE}}` syntax to `${VARIABLE}`
- Executes the resolved startup command

---

## Usage

Pull the image from GHCR:

```
docker pull ghcr.io/<org>/<image>:latest
```

Example:

```
docker pull ghcr.io/avaloncs/pelican-runner:24.04
```

Run manually:

```
docker run -it \
  -e STARTUP="echo Hello World" \
  ghcr.io/avaloncs/pelican-runner:latest
```

---

## Build

Build locally:

```
docker build -t pelican-runner:local .
```

Multi-arch build:

```
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t ghcr.io/<org>/pelican-runner:latest \
  --push .
```

---

## Notes

- The image intentionally **does not create a non-root user**
- Execution is expected to run as **root**
- Suitable for Pelican / Pterodactyl base images and custom eggs

---

## License

MIT License

---

Maintained by **Avalon Community Servers**
