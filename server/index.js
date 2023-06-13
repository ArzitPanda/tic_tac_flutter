

const express = require("express");
const { createServer } = require("http");
const { Server } = require("socket.io");
const Room = require('./models/room.js')
const app = express();
const httpServer = createServer(app);
const io = new Server(httpServer,{
  
  cors: {
    origin: "*",
    methods: ["GET", "POST"]
  }
});

io.on("connection", (socket) => {

  console.log("connected socketid "+socket.id)

  socket.on('createRoom',async ({nickname})=>{




    try{

      console.log(nickname)
      //room is created
      var room = new Room();
      room.isJoin=true;
      let player ={
        socketID:socket.id,
        nickname,
        playerType:'X',
      }
      room.players.push(player);
      room.turn=player;
    room = await room.save()
      console.log(room);
    const roomId = room._id.toString();
    socket.join(roomId)
io.to(roomId).emit('createRoomSucsess',room);

    }
    catch(err)
    {
      console.log(err)
    }



    //player is stored in room
    
  })

  socket.on('joinRoom',async({nickname,roomId})=>{

        try{

          if(!roomId.match(/^[0-9a-fA-F]{24}$/))
          {

            socket.emit('errorOccured','please enter a valid roomid')
            return;

          }

          let room = await Room.findById(new mongoose.Types.ObjectId(roomId))
          console.log(room);

          if(room.isJoin)
          {
              let player={
                nickname,
                socketID:socket.id,
                playerType:'O'

              }
              socket.join(roomId)
              room.players.push(player)
              room.isJoin= false;
              room =await room.save();
              io.to(roomId).emit('joinRoomSucsess',room);
              io.to(roomId).emit('updatePlayers',room.players);
              io.to(roomId).emit('updateRoom',room)
          }
          else{
            socket.emit('errorOccured','game is in progrress')
          }



        }
        catch(err)
        {
          console.log(err)
        }


  })

  socket.on('tap',async ({index,roomId})=>{
    try {
      let room = await Room.findById(new mongoose.Types.ObjectId(roomId))
        let choice = room.turn.playerType; // X or O
        if(room.turnIndex === 0)
        {
          room.turn = room.players[1];
          room.turnIndex = 1;
        }
        else
        {
          room.turn =room.players[0];
          room.turnIndex = 0;
        }
        room =await room.save();
io.to(roomId).emit("tapped",{index,choice,room});

    } catch (error) {
      console.log(error)
    }

  })

  socket.on('disconnect',(reason)=>{
    console.log(reason);
  })
  
});



const mongoose= require('mongoose')

mongoose.connect('mongodb+srv://arzP:Panda2001@cluster0.4hcwv.mongodb.net/?retryWrites=true&w=majority').then(res=>{
    console.log("suceesfully connected to mongodb")
}).catch(err=>console.log(err))

httpServer.listen(3000,"0.0.0.0",()=>{
  console.log("liestening to the server")

});


