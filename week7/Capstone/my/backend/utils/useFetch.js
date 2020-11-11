import { useState, useEffect } from "react";

export default function useFetch() {
	const [customers, setcampus_ride] = useState([]);
    const url = "https://react-node-mysql-app.com/campus_ride";
    
    async function getcampus_ride() {
        const response = await fetch(url);
        const json = await response.json();
        if(response.ok) {
          setcampus_ride(json.campus_ride);
        } 
      }
    
      try {
        useEffect(() => {
          getcampus_ride();
        }, []);
        return customers;
      } catch (err) {
        console.log(err);
      }
    }