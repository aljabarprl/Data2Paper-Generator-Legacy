program analisis_ekonomi
    implicit none
    
    integer, parameter :: max_data = 1000
    real :: btc(max_data), sp500(max_data), emas(max_data)
    real :: ret_btc(max_data)
    real :: mean_btc, std_btc, sharpe_btc
    integer :: n_data, i
    real :: sum_ret, sum_sq_ret, annual_factor
    real :: dummy_sp, dummy_gold 
    integer :: n_data_ret                 
    real :: ratio_pembanding             
    real, parameter :: risk_free_rate = 0.02 / 252.0  
    character(len=100) :: header        
    
    annual_factor = sqrt(252.0)

    open(unit=10, file='../data/data_ekonomi.csv', status='old', iostat=i)
    if (i /= 0) then
        print *, 'ERROR: Tidak dapat membuka ../data/data_ekonomi.csv'
        stop
    end if

    n_data = 0
    read(10, '(a)', iostat=i) header
    
    do while (.true.)
        read(10, *, iostat=i) btc(n_data+1), dummy_sp, dummy_gold
        if (i /= 0) exit
        n_data = n_data + 1
        if (n_data >= max_data) exit
    end do
    close(10)

    n_data_ret = n_data - 1

    if (n_data_ret <= 0) then
        print *, 'ERROR: Tidak ada cukup data harga untuk menghitung return.'
        mean_btc = 0.0; std_btc = 0.0; sharpe_btc = 0.0
        goto 900
    end if

    sum_ret = 0.0
    sum_sq_ret = 0.0
    do i = 1, n_data_ret
        ret_btc(i) = log(btc(i+1) / btc(i)) * 100.0 
        sum_ret = sum_ret + ret_btc(i)
        sum_sq_ret = sum_sq_ret + ret_btc(i)**2
    end do
    
    mean_btc = sum_ret / n_data_ret

    if (n_data_ret <= 1) then
        std_btc = 0.0
    else
        std_btc = sqrt((sum_sq_ret - n_data_ret * mean_btc**2) / (n_data_ret - 1))
    end if

    if (std_btc > 0.0) then
        sharpe_btc = (mean_btc - risk_free_rate) * 252.0 / (std_btc * annual_factor)
    else
        sharpe_btc = 0.0
    end if

900 continue
    
    if (n_data > 0 .and. btc(1) > 0.0) then
        ratio_pembanding = (btc(n_data) / btc(1))
    else
        ratio_pembanding = 0.0
    end if
    
   
    open(unit=20, file='../results/hasil_statistik.dat', status='replace')

    write(20, '(f10.8)') ratio_pembanding   ! Baris 1: Rasio Pembanding
    write(20, '(f10.8)') std_btc            ! Baris 2: Volatilitas
    write(20, '(f10.8)') sharpe_btc         ! Baris 3: Rasio Sharpe
    close(20)

    print *, 'Analisis selesai. Hasil disimpan di ../results/hasil_statistik.dat'

end program analisis_ekonomi