import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketUser {
  static final SocketUser _singleton = SocketUser._internal();

  SocketUser._internal();

  factory SocketUser() {
    return _singleton;
  }

  late IO.Socket socket;

  void connect() async {
    print(">>>>>>>>>>>>>>>>>>>>>>>>>connect to socket");
    try {
      // socket = IO.io('https://rencity-api2.ikitech.vn:6442', <String, dynamic>{
      socket = IO.io('https://main-api-chat.rencity.vn:6442', <String, dynamic>{
        "transports": ["websocket"],
        "autoConnect": false,
      });

      socket.connect();

      socket.onConnectError(
          (data) => print('>>>>>1==================Error : $data'));
      socket
          .onConnect((data) => print("on conected >>>>>>>>>>>>>>>>>>>>>>>>>>"));
      // print("======${socket.connected}");
      // socket.onDisconnect((_) => print('disconnect'));
    } catch (err) {
      print("==============>>>>>>>Error$err");
    }
  }

  void listenCustomerWithId(int? idCustomer, Function getData) {
    socket.on('chat:message_from_customer:$idCustomer', (data) async {
      print("vooooooooooooooo $idCustomer");
      getData(data);
    });
  }

  void listenUser(int? idCustomer, Function getData) {
    print("------------------------dang ngheeeee");
    socket.on('chat:message_from_user:$idCustomer', (data) async {
      getData(data);
    });
  }

  void listenCustomer(Function getData) {
    socket.on('chat:message_from_customer', (data) async {
      getData(data);
    });
  }

  ///

  void listenUserWithId(int? myId, int? customerId, Function getData) {
    socket.on('chat:message_from_user_to_user:$customerId:$myId', (data) async {
      getData(data);
    });
  }

  void listenUserWithGroupId(int? groupId, Function getData) {
    socket.on('chat:message_from_group:$groupId', (data) async {
      getData(data);
    });
  }

  void chatListPerson(int? myId, Function getData) {
    socket.on('chat:message_list_person:$myId', (data) async {
      getData(data);
    });
  }

  void chatListGroup(int? myId, Function getData) {
    socket.on('chat:message_list_group:$myId', (data) async {
      getData(data);
    });
  }

  void clearListen() {
    socket.clearListeners();
  }

  void close() {
    socket.clearListeners();
    socket.close();
  }
}
