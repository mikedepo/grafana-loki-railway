# Grafana + Loki Single Container Deployment

This project provides a streamlined deployment of Grafana and Loki in a single container, specifically designed for Railway.app, with NGINX handling authentication for Loki endpoints.

## Features

- Single container deployment of Grafana (v10.1.4) and Loki (v2.9.1)
- NGINX reverse proxy with basic authentication for Loki endpoints
- Grafana accessible with authentication at root path
- Preconfigured Loki data source in Grafana
- Suitable for Railway.app deployment
- Alpine-based lightweight container

## Quick Start (Railway.app Deployment)

1. Deploy to Railway.app:
   - Create a new app on Railway.app
   - Connect your GitHub repository
   - Deploy the application

2. Set the following environment variables in Railway.app dashboard:
   - `LOKI_USERNAME`: Username for Loki authentication (default: admin)
   - `LOKI_PASSWORD`: Password for Loki authentication (default: admin)
   - `GF_SECURITY_ADMIN_USER`: Grafana admin username (default: admin)
   - `GF_SECURITY_ADMIN_PASSWORD`: Grafana admin password (default: admin)

3. After the initial deployment, create a volume mount to `/data` in the Railway.app dashboard for data persistence

4. Once configured, your application will be available at the Railway-provided domain.

## Endpoints

- Grafana UI: `http://your-domain/` (requires authentication)
- Loki API: `http://your-domain/loki/` (requires basic auth)

## Local Development (Optional)

If you want to run the application locally for development:

### Prerequisites for Local Development

- Docker
- Git

### Running Locally

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/lokigrafana2.git
   cd lokigrafana2
   ```

2. Build the Docker image:
   ```bash
   docker build -t lokigrafana .
   ```

3. Run the container:
   ```bash
   docker run -p 8080:8080 \
     -e LOKI_USERNAME=admin \
     -e LOKI_PASSWORD=admin \
     -e GF_SECURITY_ADMIN_USER=admin \
     -e GF_SECURITY_ADMIN_PASSWORD=admin \
     lokigrafana
   ```

4. Access the services:
   - Grafana: `http://localhost:8080` (use GF_SECURITY_ADMIN_USER/GF_SECURITY_ADMIN_PASSWORD)
   - Loki: `http://localhost:8080/loki/` (use LOKI_USERNAME/LOKI_PASSWORD)

## Configuration

### Grafana

- Configuration file: `grafana.ini`
- Datasources are automatically provisioned
- Default port: 3000 (internal)

### Loki

- Configuration file: `loki-config.yaml`
- Default port: 3100 (internal)
- Data persistence in `/data/loki/`

### NGINX

- Configuration file: `nginx.conf`
- Handles authentication for Loki endpoints
- Proxies Grafana on root path
- Exposed port: 8080

## Data Persistence

The following directories are used for data storage:
- Loki: `/data/loki/`
- Grafana: `/data/grafana/`

For Railway.app deployment, these directories are ephemeral. For persistent storage, consider mounting volumes or using external storage solutions.

## Security

- Grafana is protected with authentication using the credentials set in environment variables
- Loki endpoints are protected with basic authentication
- Default credentials should be changed in production

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request

## License

MIT License

## Support

For issues and feature requests, please create an issue in the GitHub repository.
