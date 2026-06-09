.class Lchat/ola/vn/activity/OlaUserProfileActivity$1;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/network/c;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/activity/OlaUserProfileActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaUserProfileActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaUserProfileActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$1;->a:Lchat/ola/vn/activity/OlaUserProfileActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$1;->a:Lchat/ola/vn/activity/OlaUserProfileActivity;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->a(Lchat/ola/vn/activity/OlaUserProfileActivity;Z)Z

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$1;->a:Lchat/ola/vn/activity/OlaUserProfileActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaUserProfileActivity;->a(Lchat/ola/vn/activity/OlaUserProfileActivity;)V

    const/16 v0, 0x4002

    sput-short v0, Lchat/ola/vn/c/x;->j:S

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    sget-short v1, Lchat/ola/vn/c/x;->j:S

    invoke-virtual {v0, v1}, Lchat/ola/vn/e;->d(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 1

    invoke-static {}, Lchat/ola/vn/h;->f()Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0, p0}, Lchat/ola/vn/l/b;->b(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/network/c;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

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
    .locals 0

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
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$1;->a:Lchat/ola/vn/activity/OlaUserProfileActivity;

    const v1, 0x7f0f0521

    const v2, 0x7f0f0675

    invoke-static {v0, v1, v2}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;

    return-void
.end method
