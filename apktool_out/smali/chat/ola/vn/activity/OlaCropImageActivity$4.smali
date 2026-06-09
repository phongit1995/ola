.class final Lchat/ola/vn/activity/OlaCropImageActivity$4;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/activity/OlaCropImageActivity$b;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaCropImageActivity;->f(Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/activity/OlaCropImageActivity$a;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaCropImageActivity$a;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaCropImageActivity$a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaCropImageActivity$4;->a:Lchat/ola/vn/activity/OlaCropImageActivity$a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaCropImageActivity$4;->a:Lchat/ola/vn/activity/OlaCropImageActivity$a;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaCropImageActivity$4;->a:Lchat/ola/vn/activity/OlaCropImageActivity$a;

    invoke-interface {v0, p1}, Lchat/ola/vn/activity/OlaCropImageActivity$a;->f(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method
