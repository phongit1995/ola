.class Lchat/ola/vn/countrypicker/OlaCountryPickerActivity$2;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


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

    iput-object p1, p0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity$2;->a:Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity$2;->a:Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;

    invoke-static {p1}, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->a(Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;)Landroid/widget/EditText;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/EditText;->requestFocus()Z

    iget-object p1, p0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity$2;->a:Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;

    iget-object v0, p0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity$2;->a:Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;

    invoke-static {v0}, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->a(Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;)Landroid/widget/EditText;

    move-result-object v0

    const/4 v1, 0x1

    invoke-static {p1, v0, v1}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
