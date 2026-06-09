.class Lchat/ola/vn/activity/OlaAddContactActivity$3;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/d;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaAddContactActivity;->C()V
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

    iput-object p1, p0, Lchat/ola/vn/activity/OlaAddContactActivity$3;->a:Lchat/ola/vn/activity/OlaAddContactActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(I)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaAddContactActivity$3;->a:Lchat/ola/vn/activity/OlaAddContactActivity;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/activity/OlaAddContactActivity;->c(Z)V

    const/4 v0, 0x1

    const v1, 0x7f0f00a2

    if-eq p1, v0, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaAddContactActivity$3;->a:Lchat/ola/vn/activity/OlaAddContactActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaAddContactActivity;->b(Lchat/ola/vn/activity/OlaAddContactActivity;)Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->selectAll()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaAddContactActivity$3;->a:Lchat/ola/vn/activity/OlaAddContactActivity;

    const v0, 0x7f0f0443

    :goto_0
    invoke-static {p1, v1, v0}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaAddContactActivity$3;->a:Lchat/ola/vn/activity/OlaAddContactActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaAddContactActivity;->b(Lchat/ola/vn/activity/OlaAddContactActivity;)Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->selectAll()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaAddContactActivity$3;->a:Lchat/ola/vn/activity/OlaAddContactActivity;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const v0, 0x7f0f0258

    goto :goto_0

    :catch_0
    return-void
.end method

.method public a(Lchat/ola/vn/entity/ag;)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaAddContactActivity$3;->a:Lchat/ola/vn/activity/OlaAddContactActivity;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/activity/OlaAddContactActivity;->c(Z)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAddContactActivity$3;->a:Lchat/ola/vn/activity/OlaAddContactActivity;

    iget-object v1, p1, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    iget-object p1, p1, Lchat/ola/vn/entity/ag;->f:Ljava/lang/String;

    invoke-static {v0, v1, p1}, Lchat/ola/vn/activity/OlaAddContactActivity;->a(Lchat/ola/vn/activity/OlaAddContactActivity;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
