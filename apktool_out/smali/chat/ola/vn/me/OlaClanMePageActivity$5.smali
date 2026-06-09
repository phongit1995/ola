.class Lchat/ola/vn/me/OlaClanMePageActivity$5;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnLongClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/OlaClanMePageActivity;->C()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/me/OlaClanMePageActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/OlaClanMePageActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/OlaClanMePageActivity$5;->a:Lchat/ola/vn/me/OlaClanMePageActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onLongClick(Landroid/view/View;)Z
    .locals 2

    invoke-static {}, Lchat/ola/vn/q/b;->a()Lchat/ola/vn/q/b;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity$5;->a:Lchat/ola/vn/me/OlaClanMePageActivity;

    invoke-virtual {v0, v1, p1}, Lchat/ola/vn/q/b;->a(Landroid/content/Context;Landroid/view/View;)Z

    move-result p1

    return p1
.end method
