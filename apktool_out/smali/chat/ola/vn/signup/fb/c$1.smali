.class Lchat/ola/vn/signup/fb/c$1;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/network/c;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/signup/fb/c;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/signup/fb/c;


# direct methods
.method constructor <init>(Lchat/ola/vn/signup/fb/c;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/signup/fb/c$1;->a:Lchat/ola/vn/signup/fb/c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 3

    const/4 v0, 0x1

    :try_start_0
    invoke-static {}, Lchat/ola/vn/util/f;->a()Lchat/ola/vn/util/f;

    move-result-object v1

    const-string v2, "Reg nick by FB OK"

    invoke-virtual {v1, v2}, Lchat/ola/vn/util/f;->c(Ljava/lang/String;)V

    sput-boolean v0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->f:Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v1, :cond_0

    invoke-static {p1}, Lchat/ola/vn/h;->d(Ljava/lang/String;)V

    invoke-static {p2}, Lchat/ola/vn/h;->b(Ljava/lang/String;)V

    invoke-static {p3}, Lchat/ola/vn/h;->c(Ljava/lang/String;)V

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v1

    invoke-virtual {v1, p1}, Lchat/ola/vn/e;->a(Ljava/lang/String;)V

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v1

    invoke-virtual {v1, p3}, Lchat/ola/vn/e;->b(Ljava/lang/String;)V

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v1

    const/4 v2, 0x0

    invoke-static {v1, p1, p2, p3, v2}, Lchat/ola/vn/h/b;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p2, p1}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;)V

    :cond_0
    const/4 p1, 0x0

    sput-boolean p1, Lchat/ola/vn/tutorial/OlaTutorialActivity;->e:Z

    sput-boolean v0, Lchat/ola/vn/activity/OlaBottomTabActivity;->g:Z

    iget-object p2, p0, Lchat/ola/vn/signup/fb/c$1;->a:Lchat/ola/vn/signup/fb/c;

    invoke-virtual {p2}, Lchat/ola/vn/signup/fb/c;->v()V

    iget-object p2, p0, Lchat/ola/vn/signup/fb/c$1;->a:Lchat/ola/vn/signup/fb/c;

    invoke-virtual {p2}, Lchat/ola/vn/signup/fb/c;->e()Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    move-result-object p2

    invoke-virtual {p2, p1}, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->c(Z)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

.method public a(Ljava/lang/String;Z)V
    .locals 0

    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public a(S)V
    .locals 3

    if-eqz p1, :cond_5

    const/4 v0, 0x3

    if-eq p1, v0, :cond_4

    const/4 v0, 0x7

    if-eq p1, v0, :cond_3

    const/16 v0, 0xa

    if-eq p1, v0, :cond_2

    const/16 v0, 0x16

    if-eq p1, v0, :cond_1

    const/16 v0, 0x20

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    :try_start_0
    invoke-static {}, Lchat/ola/vn/util/f;->a()Lchat/ola/vn/util/f;

    move-result-object p1

    const-string v0, "Reg nick by FB FAIL: FAIL_LOGIN_SERVER_BUSY"

    invoke-virtual {p1, v0}, Lchat/ola/vn/util/f;->c(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/signup/fb/c$1;->a:Lchat/ola/vn/signup/fb/c;

    invoke-virtual {p1}, Lchat/ola/vn/signup/fb/c;->e()Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/signup/fb/c$1;->a:Lchat/ola/vn/signup/fb/c;

    const v1, 0x7f0f0358

    invoke-virtual {v0, v1}, Lchat/ola/vn/signup/fb/c;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lchat/ola/vn/util/j;->c(Landroid/content/Context;Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/signup/fb/c$1;->a:Lchat/ola/vn/signup/fb/c;

    invoke-virtual {p1}, Lchat/ola/vn/signup/fb/c;->e()Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/activity/OlaLoginActivity;->a(Landroid/content/Context;)Z

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/signup/fb/c$1;->a:Lchat/ola/vn/signup/fb/c;

    invoke-virtual {p1}, Lchat/ola/vn/signup/fb/c;->v()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_5

    return-void

    :cond_1
    :try_start_2
    invoke-static {}, Lchat/ola/vn/util/f;->a()Lchat/ola/vn/util/f;

    move-result-object p1

    const-string v0, "Reg nick by FB FAIL: FAIL_INACTIVATED_ACCOUNT"

    invoke-virtual {p1, v0}, Lchat/ola/vn/util/f;->c(Ljava/lang/String;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :try_start_3
    iget-object p1, p0, Lchat/ola/vn/signup/fb/c$1;->a:Lchat/ola/vn/signup/fb/c;

    invoke-virtual {p1}, Lchat/ola/vn/signup/fb/c;->e()Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/signup/fb/c$1;->a:Lchat/ola/vn/signup/fb/c;

    const v1, 0x7f0f04eb

    invoke-virtual {v0, v1}, Lchat/ola/vn/signup/fb/c;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lchat/ola/vn/util/j;->c(Landroid/content/Context;Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/signup/fb/c$1;->a:Lchat/ola/vn/signup/fb/c;

    invoke-virtual {p1}, Lchat/ola/vn/signup/fb/c;->e()Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/activity/OlaLoginActivity;->a(Landroid/content/Context;)Z
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_5

    goto :goto_0

    :cond_2
    :try_start_4
    invoke-static {}, Lchat/ola/vn/util/f;->a()Lchat/ola/vn/util/f;

    move-result-object p1

    const-string v0, "Reg nick by FB FAIL: FAIL_INVALID_PASSWORD"

    invoke-virtual {p1, v0}, Lchat/ola/vn/util/f;->c(Ljava/lang/String;)V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    :catch_2
    :try_start_5
    iget-object p1, p0, Lchat/ola/vn/signup/fb/c$1;->a:Lchat/ola/vn/signup/fb/c;

    invoke-virtual {p1}, Lchat/ola/vn/signup/fb/c;->e()Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/signup/fb/c$1;->a:Lchat/ola/vn/signup/fb/c;

    const v1, 0x7f0f0253

    invoke-virtual {v0, v1}, Lchat/ola/vn/signup/fb/c;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lchat/ola/vn/util/j;->c(Landroid/content/Context;Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/signup/fb/c$1;->a:Lchat/ola/vn/signup/fb/c;

    invoke-virtual {p1}, Lchat/ola/vn/signup/fb/c;->e()Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/activity/OlaLoginActivity;->a(Landroid/content/Context;)Z
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_5

    goto :goto_0

    :cond_3
    :try_start_6
    invoke-static {}, Lchat/ola/vn/util/f;->a()Lchat/ola/vn/util/f;

    move-result-object p1

    const-string v0, "Reg nick by FB FAIL: FAIL_INVALID_USERNAME_PASSWORD"

    invoke-virtual {p1, v0}, Lchat/ola/vn/util/f;->c(Ljava/lang/String;)V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_3

    :catch_3
    :try_start_7
    iget-object p1, p0, Lchat/ola/vn/signup/fb/c$1;->a:Lchat/ola/vn/signup/fb/c;

    invoke-virtual {p1}, Lchat/ola/vn/signup/fb/c;->e()Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/signup/fb/c$1;->a:Lchat/ola/vn/signup/fb/c;

    const v1, 0x7f0f0268

    invoke-virtual {v0, v1}, Lchat/ola/vn/signup/fb/c;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lchat/ola/vn/util/j;->c(Landroid/content/Context;Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/signup/fb/c$1;->a:Lchat/ola/vn/signup/fb/c;

    invoke-virtual {p1}, Lchat/ola/vn/signup/fb/c;->e()Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/activity/OlaLoginActivity;->a(Landroid/content/Context;)Z
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_5

    goto :goto_0

    :cond_4
    :try_start_8
    invoke-static {}, Lchat/ola/vn/util/f;->a()Lchat/ola/vn/util/f;

    move-result-object v0

    const-string v1, "Reg nick by FB FAIL: FAIL_DUPLICATED_USERNAME"

    invoke-virtual {v0, v1}, Lchat/ola/vn/util/f;->c(Ljava/lang/String;)V
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_4

    :catch_4
    :try_start_9
    iget-object v0, p0, Lchat/ola/vn/signup/fb/c$1;->a:Lchat/ola/vn/signup/fb/c;

    invoke-virtual {v0}, Lchat/ola/vn/signup/fb/c;->e()Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->c(Z)V

    iget-object v0, p0, Lchat/ola/vn/signup/fb/c$1;->a:Lchat/ola/vn/signup/fb/c;

    invoke-virtual {v0}, Lchat/ola/vn/signup/fb/c;->e()Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->C()Lchat/ola/vn/signup/fb/b;

    move-result-object v0

    new-instance v1, Landroid/os/Bundle;

    invoke-direct {v1}, Landroid/os/Bundle;-><init>()V

    const-string v2, "_result"

    invoke-virtual {v1, v2, p1}, Landroid/os/Bundle;->putShort(Ljava/lang/String;S)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/signup/fb/b;->setArguments(Landroid/os/Bundle;)V

    return-void

    :cond_5
    iget-object p1, p0, Lchat/ola/vn/signup/fb/c$1;->a:Lchat/ola/vn/signup/fb/c;

    invoke-virtual {p1}, Lchat/ola/vn/signup/fb/c;->e()Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/signup/fb/c$1;->a:Lchat/ola/vn/signup/fb/c;

    const v1, 0x7f0f0263

    invoke-virtual {v0, v1}, Lchat/ola/vn/signup/fb/c;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lchat/ola/vn/util/j;->c(Landroid/content/Context;Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/signup/fb/c$1;->a:Lchat/ola/vn/signup/fb/c;

    invoke-virtual {p1}, Lchat/ola/vn/signup/fb/c;->e()Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/activity/OlaLoginActivity;->a(Landroid/content/Context;)Z
    :try_end_9
    .catch Ljava/lang/Throwable; {:try_start_9 .. :try_end_9} :catch_5

    goto/16 :goto_0

    :catch_5
    return-void
.end method

.method public b()V
    .locals 0

    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public b(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public b(S)V
    .locals 0

    return-void
.end method

.method public c()V
    .locals 0

    return-void
.end method

.method public d()V
    .locals 0

    return-void
.end method
