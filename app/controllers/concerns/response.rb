module Response
  def result(code, msg, data)
    {
      code: code,
      msg: msg,
      data: data
    }
  end

  def success(msg='OK', data={})
    render json: result(0, msg, data)
  end

  def fail(msg='FAIL', data={})
    render json: result(1, msg, data)
  end

  def json_response(object, status = :ok)
    render json: object, status: status
  end
end
