package dao;

public interface IDAO<T> {
    public int insert(T model);
    public int update(T model);
    public int delete(T model);
}
