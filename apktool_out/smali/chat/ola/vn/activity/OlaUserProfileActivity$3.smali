.class Lchat/ola/vn/activity/OlaUserProfileActivity$3;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaUserProfileActivity;->onClick(Landroid/view/View;)V
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

    iput-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$3;->a:Lchat/ola/vn/activity/OlaUserProfileActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 1

    if-nez p2, :cond_0

    :try_start_0
    invoke-static {}, Lchat/ola/vn/h;->f()Ljava/lang/String;

    move-result-object p2

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$3;->a:Lchat/ola/vn/activity/OlaUserProfileActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaUserProfileActivity;->d(Lchat/ola/vn/activity/OlaUserProfileActivity;)Lchat/ola/vn/network/c;

    move-result-object v0

    invoke-static {p2, v0}, Lchat/ola/vn/l/b;->b(Ljava/lang/String;Lchat/ola/vn/network/c;)V

    goto :goto_0

    :catch_0
    move-exception p1

    goto :goto_1

    :cond_0
    :goto_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->cancel()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :goto_1
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method
