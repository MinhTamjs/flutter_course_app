
class User{
  
  const User({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.avatar
  });

  const User.empty() : this(id: 1, createdAt: 'empty.createdAt', name: 'empty.name', avatar: 'empty.avatar');

  
  final int id;
  final String createdAt;
  final String name;
  final String avatar;

  @override
  List<Object?> get props => [id]; 
}

