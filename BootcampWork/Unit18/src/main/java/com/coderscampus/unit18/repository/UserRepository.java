package com.coderscampus.unit18.repository;

import com.coderscampus.unit18.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
//  JpaRepository<T, ID>
    // T is the type of data class that is the domain object the repository will be interacting with
    //    aka what @Entity are we working with
    //    each repository is going to have queries that correspond with one table

    // ID is the data type of the @ID that we are using

//don't need to say public in method below because in an interface it is public by default
    List<User> findByUsername(String username);


    List<User> findByName(String name);

//        select * from, name of column, And or Or, name of another column, (specific value in a column, another specific value in another column)
//    select * from users where name = :name and username = :username
    List<User> findByNameAndUsername(String name, String username);


    List<User>findByCreatedDateBetween(LocalDate date1, LocalDate date2);

    @Query("select u from User u where username = :username")
    List<User> findExactlyOneUserByUsername(String username);

    @Query("select u from User u"
        + " left join fetch u.accounts"
        + " left join fetch u.address")
    List<User> findAll();


}
