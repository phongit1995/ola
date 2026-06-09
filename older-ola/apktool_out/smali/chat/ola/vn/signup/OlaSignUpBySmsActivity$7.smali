.class Lchat/ola/vn/signup/OlaSignUpBySmsActivity$7;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->d(Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$7;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$7;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-static {v0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->k(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)Landroid/app/ProgressDialog;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/ProgressDialog;->dismiss()V

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$7;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->a(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;Landroid/app/ProgressDialog;)Landroid/app/ProgressDialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$7;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-static {v0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->d(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)Landroid/widget/EditText;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lchat/ola/vn/signup/c;->a:Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$7;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-static {v0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->i(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method
