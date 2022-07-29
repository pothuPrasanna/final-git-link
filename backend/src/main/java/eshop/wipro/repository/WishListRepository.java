package eshop.wipro.repository;


import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import eshop.wipro.entity.WishList;

@Repository
public interface WishListRepository extends JpaRepository<WishList, Integer> {

    Page<WishList> findAllByUserId(Long id, Pageable pageable);

	
    


}
