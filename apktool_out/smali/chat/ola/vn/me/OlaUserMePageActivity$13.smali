.class Lchat/ola/vn/me/OlaUserMePageActivity$13;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/d;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/OlaUserMePageActivity;->K()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/me/OlaUserMePageActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/OlaUserMePageActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$13;->a:Lchat/ola/vn/me/OlaUserMePageActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(I)V
    .locals 2

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$13;->a:Lchat/ola/vn/me/OlaUserMePageActivity;

    const/4 v0, 0x0

    invoke-static {p1, v0}, Lchat/ola/vn/me/OlaUserMePageActivity;->b(Lchat/ola/vn/me/OlaUserMePageActivity;Z)V

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$13;->a:Lchat/ola/vn/me/OlaUserMePageActivity;

    const/4 v0, 0x1

    invoke-static {p1, v0}, Lchat/ola/vn/me/OlaUserMePageActivity;->c(Lchat/ola/vn/me/OlaUserMePageActivity;Z)Z

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$13;->a:Lchat/ola/vn/me/OlaUserMePageActivity;

    const v0, 0x7f0f009f

    const v1, 0x7f0f019f

    invoke-static {p1, v0, v1}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;

    return-void
.end method

.method public a(Lchat/ola/vn/entity/ag;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity$13;->a:Lchat/ola/vn/me/OlaUserMePageActivity;

    iput-object p1, v0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$13;->a:Lchat/ola/vn/me/OlaUserMePageActivity;

    invoke-static {p1}, Lchat/ola/vn/me/OlaUserMePageActivity;->f(Lchat/ola/vn/me/OlaUserMePageActivity;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
