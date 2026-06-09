.class Lchat/ola/vn/activity/OlaUserProfileActivity$5;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaUserProfileActivity;->f(Ljava/lang/String;)V
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

    iput-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$5;->a:Lchat/ola/vn/activity/OlaUserProfileActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 1

    if-eqz p2, :cond_0

    goto :goto_0

    :cond_0
    :try_start_0
    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p2}, Lchat/ola/vn/network/OlaNetworkService;->v()V

    iget-object p2, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$5;->a:Lchat/ola/vn/activity/OlaUserProfileActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaUserProfileActivity;->e(Lchat/ola/vn/activity/OlaUserProfileActivity;)Lchat/ola/vn/entity/ag;

    move-result-object p2

    const/4 v0, 0x0

    iput-object v0, p2, Lchat/ola/vn/entity/ag;->e:Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$5;->a:Lchat/ola/vn/activity/OlaUserProfileActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaUserProfileActivity;->f(Lchat/ola/vn/activity/OlaUserProfileActivity;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :goto_0
    :try_start_1
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method
