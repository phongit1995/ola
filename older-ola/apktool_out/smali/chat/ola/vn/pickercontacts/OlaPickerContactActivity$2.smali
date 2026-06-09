.class Lchat/ola/vn/pickercontacts/OlaPickerContactActivity$2;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/text/TextWatcher;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->E()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity$2;->a:Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity$2;->a:Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;

    invoke-static {v0}, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->a(Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;)Lchat/ola/vn/pickercontacts/h;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity$2;->a:Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;

    invoke-static {v0}, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->a(Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;)Lchat/ola/vn/pickercontacts/h;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/pickercontacts/h;->getFilter()Landroid/widget/Filter;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/widget/Filter;->filter(Ljava/lang/CharSequence;)V

    :cond_0
    return-void
.end method

.method public beforeTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    return-void
.end method

.method public onTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    return-void
.end method
