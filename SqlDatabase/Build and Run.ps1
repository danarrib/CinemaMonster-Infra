# Build Database Container
docker build -t cinemasql .

# Run the image
docker run --name cinema_sqlserver -p 1433:1433 -d cinemasql
