.class Lchat/ola/vn/countrypicker/OlaCountryPickerActivity$4;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/text/TextWatcher;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity$4;->a:Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity$4;->a:Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, p1}, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->a(Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;Ljava/lang/String;)V

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
