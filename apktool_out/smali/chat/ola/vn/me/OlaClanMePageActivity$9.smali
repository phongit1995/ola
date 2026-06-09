.class Lchat/ola/vn/me/OlaClanMePageActivity$9;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/OlaClanMePageActivity;->R()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entry/c/e;

.field final synthetic b:Lchat/ola/vn/me/OlaClanMePageActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/OlaClanMePageActivity;Lchat/ola/vn/entry/c/e;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/OlaClanMePageActivity$9;->b:Lchat/ola/vn/me/OlaClanMePageActivity;

    iput-object p2, p0, Lchat/ola/vn/me/OlaClanMePageActivity$9;->a:Lchat/ola/vn/entry/c/e;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 3

    if-nez p2, :cond_0

    :try_start_0
    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "#"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity$9;->b:Lchat/ola/vn/me/OlaClanMePageActivity;

    iget-object v1, v1, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iget-object v1, v1, Lchat/ola/vn/entity/b;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity$9;->a:Lchat/ola/vn/entry/c/e;

    invoke-static {v1}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v1

    const/4 v2, 0x0

    invoke-virtual {p2, v0, v2, v1}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;ZS)V

    iget-object p2, p0, Lchat/ola/vn/me/OlaClanMePageActivity$9;->b:Lchat/ola/vn/me/OlaClanMePageActivity;

    iget-object p2, p2, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iput-boolean v2, p2, Lchat/ola/vn/entity/b;->k:Z

    iget-object p2, p0, Lchat/ola/vn/me/OlaClanMePageActivity$9;->b:Lchat/ola/vn/me/OlaClanMePageActivity;

    invoke-static {p2}, Lchat/ola/vn/me/OlaClanMePageActivity;->f(Lchat/ola/vn/me/OlaClanMePageActivity;)V

    :cond_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
