.class Lchat/ola/vn/activity/OlaChatViewActivity$12;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/util/d/a$a;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaChatViewActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaChatViewActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaChatViewActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$12;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 7

    :try_start_0
    sget-boolean v0, Lchat/ola/vn/c/x;->s:Z

    if-eqz v0, :cond_0

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$12;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {v2}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object v2

    iget-wide v2, v2, Lchat/ola/vn/message/f;->t:J

    const/4 v4, 0x0

    sub-long v4, v0, v2

    const-wide/16 v2, 0x2710

    cmp-long v6, v4, v2

    if-lez v6, :cond_0

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$12;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    sget-object v3, Lchat/ola/vn/f/c;->a:Ljava/lang/String;

    const/4 v4, 0x0

    invoke-static {v2, v3, v4, v4}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;Ljava/lang/String;IZ)V

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$12;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {v2}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object v2

    iput-wide v0, v2, Lchat/ola/vn/message/f;->t:J
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method
