.class public abstract Lchat/ola/vn/signup/a;
.super Lchat/ola/vn/m/f;


# instance fields
.field private a:Lchat/ola/vn/signup/a;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/f;-><init>()V

    return-void
.end method


# virtual methods
.method a(Lchat/ola/vn/signup/a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/signup/a;->a:Lchat/ola/vn/signup/a;

    return-void
.end method

.method public abstract c()Lchat/ola/vn/signup/a;
.end method

.method public final d()Lchat/ola/vn/signup/a;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/signup/a;->a:Lchat/ola/vn/signup/a;

    return-object v0
.end method

.method public abstract e()Ljava/lang/String;
.end method

.method public abstract h()Ljava/lang/String;
.end method

.method public j()Lchat/ola/vn/signup/OlaSignUpActivity;
    .locals 1

    invoke-virtual {p0}, Lchat/ola/vn/signup/a;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/signup/a;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    instance-of v0, v0, Lchat/ola/vn/signup/OlaSignUpActivity;

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/signup/a;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/signup/OlaSignUpActivity;

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public v()V
    .locals 1

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/signup/a;->j()Lchat/ola/vn/signup/OlaSignUpActivity;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/signup/OlaSignUpActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public x()V
    .locals 0

    return-void
.end method
