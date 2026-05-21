program helloworld
use mpi
integer ierr, numprocs, procid

call MPI_INIT(ierr)

call MPI_COMM_RANK(MPI_COMM_WORLD, procid, ierr)
call MPI_COMM_SIZE(MPI_COMM_WORLD, numprocs, ierr)

print *, " I am process ", procid, "out of", numprocs, "on host ",hostname,"!"

call MPI_FINALIZE(ierr)

stop
end