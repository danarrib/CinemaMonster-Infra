docker run -p 6379:6379 --name cinema_redis `
--net CinemaNetwork -d redis:6
