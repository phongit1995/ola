.class Lchat/ola/vn/activity/OlaAddContactActivity$2;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/view/OlaQuickTypingSuggestedText$b;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaAddContactActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaAddContactActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaAddContactActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaAddContactActivity$2;->a:Lchat/ola/vn/activity/OlaAddContactActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public b_(Ljava/lang/String;)V
    .locals 0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaAddContactActivity$2;->a:Lchat/ola/vn/activity/OlaAddContactActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaAddContactActivity;->a(Lchat/ola/vn/activity/OlaAddContactActivity;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method
