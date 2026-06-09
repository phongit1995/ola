.class Lchat/ola/vn/activity/OlaBottomTabActivity$5;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/p;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaBottomTabActivity;->a(Lchat/ola/vn/view/OlaTabViewLayout$c;I)Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/i/c;

.field final synthetic b:Lchat/ola/vn/activity/OlaBottomTabActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaBottomTabActivity;Lchat/ola/vn/i/c;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaBottomTabActivity$5;->b:Lchat/ola/vn/activity/OlaBottomTabActivity;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaBottomTabActivity$5;->a:Lchat/ola/vn/i/c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity$5;->a:Lchat/ola/vn/i/c;

    invoke-virtual {v0}, Lchat/ola/vn/i/c;->a()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity$5;->b:Lchat/ola/vn/activity/OlaBottomTabActivity;

    invoke-static {v0, p1}, Lchat/ola/vn/util/b;->n(Landroid/content/Context;Ljava/lang/String;)V

    return-void
.end method
