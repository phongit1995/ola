.class Lchat/ola/vn/me/OlaUserMePageActivity$5;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/OlaUserMePageActivity;->Z()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entry/c/e;

.field final synthetic b:Lchat/ola/vn/me/OlaUserMePageActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/OlaUserMePageActivity;Lchat/ola/vn/entry/c/e;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$5;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    iput-object p2, p0, Lchat/ola/vn/me/OlaUserMePageActivity$5;->a:Lchat/ola/vn/entry/c/e;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 3

    if-nez p2, :cond_0

    :try_start_0
    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity$5;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    iget-object v0, v0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v0, v0, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$5;->a:Lchat/ola/vn/entry/c/e;

    invoke-static {v1}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v1

    const/4 v2, 0x0

    invoke-virtual {p2, v0, v2, v1}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;ZS)V

    iget-object p2, p0, Lchat/ola/vn/me/OlaUserMePageActivity$5;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    iget-object p2, p2, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iput-boolean v2, p2, Lchat/ola/vn/entity/ag;->y:Z

    iget-object p2, p0, Lchat/ola/vn/me/OlaUserMePageActivity$5;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    invoke-static {p2}, Lchat/ola/vn/me/OlaUserMePageActivity;->f(Lchat/ola/vn/me/OlaUserMePageActivity;)V

    :cond_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
