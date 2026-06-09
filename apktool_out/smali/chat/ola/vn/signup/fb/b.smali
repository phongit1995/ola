.class public abstract Lchat/ola/vn/signup/fb/b;
.super Lchat/ola/vn/m/f;


# instance fields
.field private a:Lchat/ola/vn/signup/fb/b;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/f;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/signup/fb/b;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/signup/fb/b;->a:Lchat/ola/vn/signup/fb/b;

    return-void
.end method

.method public a(Ljava/lang/Class;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;)V"
        }
    .end annotation

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/signup/fb/b;->e()Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    move-result-object v0

    invoke-virtual {v0, p1}, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->a(Ljava/lang/Class;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public abstract c()Lchat/ola/vn/signup/fb/b;
.end method

.method public final d()Lchat/ola/vn/signup/fb/b;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/signup/fb/b;->a:Lchat/ola/vn/signup/fb/b;

    return-object v0
.end method

.method public e()Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;
    .locals 1

    invoke-virtual {p0}, Lchat/ola/vn/signup/fb/b;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/signup/fb/b;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    instance-of v0, v0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/signup/fb/b;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public h()Ljava/lang/String;
    .locals 1

    const/4 v0, 0x0

    return-object v0
.end method

.method public j()V
    .locals 0

    return-void
.end method

.method public v()V
    .locals 1

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/signup/fb/b;->e()Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
