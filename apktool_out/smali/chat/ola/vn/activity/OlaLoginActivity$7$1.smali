.class Lchat/ola/vn/activity/OlaLoginActivity$7$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaLoginActivity$7;->a(Ljava/lang/String;Ljava/util/List;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Lchat/ola/vn/activity/OlaLoginActivity$7;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaLoginActivity$7;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity$7$1;->b:Lchat/ola/vn/activity/OlaLoginActivity$7;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaLoginActivity$7$1;->a:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0

    :try_start_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    if-eqz p2, :cond_0

    return-void

    :cond_0
    new-instance p1, Lchat/ola/vn/activity/OlaLoginActivity$7$1$1;

    invoke-direct {p1, p0}, Lchat/ola/vn/activity/OlaLoginActivity$7$1$1;-><init>(Lchat/ola/vn/activity/OlaLoginActivity$7$1;)V

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaLoginActivity$7$1;->a:Ljava/lang/String;

    invoke-virtual {p1, p2}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
