//
//  CCEnumResult.swift
//  CCDevKit
//
//  Created by cc on 2021/8/5.
//

import Foundation
public typealias CCNullBlock = () -> Void
public typealias CCValueBlock<Value> = (_: Value) -> Void

public enum CCResult<Value0, Value1> {
    case success(Value0)
    case failure(Value1)
}

public enum CCValueResult<Value> {
    case success(Value)
    case failure(Value)
}

public enum CCNullResult {
    case success
    case failure
}

public enum CCSuccessResult<Value> {
    case success(Value)
    case failure
}

public enum CCErrorResult<Value> {
    case success
    case failure(Value)
}
