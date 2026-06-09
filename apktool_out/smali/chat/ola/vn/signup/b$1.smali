.class Lchat/ola/vn/signup/b$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/text/TextWatcher;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/signup/b;->a(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/signup/b;


# direct methods
.method constructor <init>(Lchat/ola/vn/signup/b;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/signup/b$1;->a:Lchat/ola/vn/signup/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 1

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/signup/b$1;->a:Lchat/ola/vn/signup/b;

    invoke-static {p1}, Lchat/ola/vn/signup/b;->a(Lchat/ola/vn/signup/b;)Landroid/widget/TextView;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object p1

    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/signup/b$1;->a:Lchat/ola/vn/signup/b;

    invoke-static {v0}, Lchat/ola/vn/signup/b;->b(Lchat/ola/vn/signup/b;)Landroid/widget/EditText;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->g(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    sput-object p1, Lchat/ola/vn/signup/OlaSignUpActivity;->h:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
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
