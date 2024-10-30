// codeunit 50113 "No. Series"
// {
//     // Existing code

//     var
//         NoSeriesBatch: Codeunit "No. Series - Batch";

//     trigger OnInsert()
//     begin
//         if "Receipt No." = '' then begin
//             "Receipt No." := NoSeriesBatch.GetNextNo('RECEIPT', WorkDate);
//             if "Receipt No." = '' then
//                 Error('Unable to generate receipt number. Please check the number series setup.');
//             NoSeriesBatch.SaveState();
//         end;
//     end;
// }