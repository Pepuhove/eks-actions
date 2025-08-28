# ---------- Stage 1: Collect static files ----------
FROM alpine:3.20 AS builder
WORKDIR /site
COPY src/ .

# ---------- Stage 2: Serve with Nginx securely ----------
FROM nginx:alpine

# Add non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup \
    && rm -rf /usr/share/nginx/html/* \
    && chown -R appuser:appgroup /usr/share/nginx/html

# Copy files from builder
COPY --from=builder /site/ /usr/share/nginx/html/

# Switch to non-root user
USER appuser

# Expose HTTP port
EXPOSE 80

# Run Nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
# Note: For production, consider adding SSL and other security measures.