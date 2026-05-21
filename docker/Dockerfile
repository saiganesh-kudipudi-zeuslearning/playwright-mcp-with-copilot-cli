FROM mcr.microsoft.com/playwright:v1.59.1-jammy

# ── Node.js (latest LTS) ──────────────────────────────────────────────────────
RUN apt-get update && apt-get install -y curl wget unzip gnupg2 ca-certificates \
    && curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm@latest \
    && node -v && npm -v

# ── GitLab CLI ────────────────────────────────────────────────────────────────
RUN curl -fsSL https://gitlab.com/gitlab-org/cli/-/releases/permalink/latest/downloads/glab_linux_amd64.tar.gz \
        -o glab.tar.gz \
    && tar -xzf glab.tar.gz \
    && mv bin/glab /usr/local/bin/ \
    && rm -rf glab.tar.gz bin/ \
    && glab --version

# ── GitHub Copilot CLI (Official) ─────────────────────────────────────────────
RUN curl -fsSL https://gh.io/copilot-install | bash \
    && copilot --version || true

# ── Cleanup ───────────────────────────────────────────────────────────────────
RUN apt-get clean && rm -rf /var/lib/apt/lists/*