.class Lchat/ola/vn/activity/OlaLoginActivity$17;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaLoginActivity;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Ljava/lang/String;

.field final synthetic d:Ljava/lang/String;

.field final synthetic e:Lchat/ola/vn/activity/OlaLoginActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaLoginActivity;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity$17;->e:Lchat/ola/vn/activity/OlaLoginActivity;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaLoginActivity$17;->a:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/activity/OlaLoginActivity$17;->b:Ljava/lang/String;

    iput-object p4, p0, Lchat/ola/vn/activity/OlaLoginActivity$17;->c:Ljava/lang/String;

    iput-object p5, p0, Lchat/ola/vn/activity/OlaLoginActivity$17;->d:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity$17;->e:Lchat/ola/vn/activity/OlaLoginActivity;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaLoginActivity$17;->a:Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaLoginActivity$17;->b:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/activity/OlaLoginActivity$17;->c:Ljava/lang/String;

    iget-object v4, p0, Lchat/ola/vn/activity/OlaLoginActivity$17;->d:Ljava/lang/String;

    invoke-static {v0, v1, v2, v3, v4}, Lchat/ola/vn/activity/OlaLoginActivity;->a(Lchat/ola/vn/activity/OlaLoginActivity;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
