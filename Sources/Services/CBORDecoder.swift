import Foundation
import SwiftCBOR

let cwtTag = UInt64(61)

public class CBORDecoder : SwiftCBOR.CBORDecoder
{
     public override func decodeItem() throws -> CBOR? {
        let decoder = SwiftCBOR.CBORDecoder(input: data.uint)

        guard
            let cbor = try? decoder.decodeItem(),
            case let SwiftCBOR.CBOR.tagged(tag, cborElement) = cbor,
            tag.rawValue == coseTag, // SIGN1
            return cbor;
        }
        else
        {
            guard
                let cbor = try? decoder.decodeItem(),
                case let SwiftCBOR.CBOR.tagged(tag, cborElement) = cbor,
                tag.rawValue == cwtTag, // CWT
                decoder = SwiftCBOR.CBORDecoder(cbor)
                cbor = try? decoder.decodeItem()
                case let SwiftCBOR.CBOR.tagged(tag, cborElement) = cbor,
                tag.rawValue == coseTag, // SIGN1
                return cbor;
            else {
                return nil
            }
        }
        return nil;
     }
}