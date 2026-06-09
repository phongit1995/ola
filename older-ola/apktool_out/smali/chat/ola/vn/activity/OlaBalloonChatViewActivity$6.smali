.class Lchat/ola/vn/activity/OlaBalloonChatViewActivity$6;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->a(Ljava/lang/String;IZ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/message/d;

.field final synthetic b:S

.field final synthetic c:Ljava/lang/String;

.field final synthetic d:I

.field final synthetic e:Ljava/lang/String;

.field final synthetic f:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;Lchat/ola/vn/message/d;SLjava/lang/String;ILjava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$6;->f:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$6;->a:Lchat/ola/vn/message/d;

    iput-short p3, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$6;->b:S

    iput-object p4, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$6;->c:Ljava/lang/String;

    iput p5, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$6;->d:I

    iput-object p6, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$6;->e:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private a()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$6;->a:Lchat/ola/vn/message/d;

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/d;->b(B)V

    new-instance v0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$6$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$6$1;-><init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity$6;)V

    const-wide/32 v1, 0xea60

    invoke-static {v0, v1, v2}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    :try_start_0
    iget-short v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$6;->b:S

    const/4 v1, 0x4

    const/4 v2, 0x2

    if-eq v0, v1, :cond_0

    packed-switch v0, :pswitch_data_0

    return-void

    :pswitch_0
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$6;->a:Lchat/ola/vn/message/d;

    invoke-virtual {v1}, Lchat/ola/vn/message/d;->j()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$6;->c:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$6;->a:Lchat/ola/vn/message/d;

    invoke-virtual {v3}, Lchat/ola/vn/message/d;->p()Ljava/lang/String;

    move-result-object v3

    iget v4, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$6;->d:I

    int-to-short v4, v4

    invoke-virtual {v0, v1, v2, v3, v4}, Lchat/ola/vn/network/OlaNetworkService;->c(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V

    :goto_0
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$6;->a()V

    return-void

    :pswitch_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$6;->a:Lchat/ola/vn/message/d;

    invoke-virtual {v0, v2}, Lchat/ola/vn/message/d;->b(B)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$6;->a:Lchat/ola/vn/message/d;

    invoke-virtual {v1}, Lchat/ola/vn/message/d;->j()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$6;->c:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$6;->a:Lchat/ola/vn/message/d;

    invoke-virtual {v3}, Lchat/ola/vn/message/d;->p()Ljava/lang/String;

    move-result-object v3

    iget v4, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$6;->d:I

    int-to-short v4, v4

    invoke-virtual {v0, v1, v2, v3, v4}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V

    return-void

    :pswitch_2
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$6;->a:Lchat/ola/vn/message/d;

    invoke-virtual {v1}, Lchat/ola/vn/message/d;->j()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$6;->c:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$6;->a:Lchat/ola/vn/message/d;

    invoke-virtual {v3}, Lchat/ola/vn/message/d;->p()Ljava/lang/String;

    move-result-object v3

    iget v4, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$6;->d:I

    int-to-short v4, v4

    invoke-virtual {v0, v1, v2, v3, v4}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$6;->e:Ljava/lang/String;

    invoke-static {v0}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v0

    sget-object v3, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v4, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$6;->a:Lchat/ola/vn/message/d;

    invoke-virtual {v4}, Lchat/ola/vn/message/d;->k()Ljava/lang/String;

    move-result-object v4

    iget-object v5, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$6;->a:Lchat/ola/vn/message/d;

    invoke-virtual {v5}, Lchat/ola/vn/message/d;->o()S

    move-result v5

    invoke-virtual {v3, v0, v1, v4, v5}, Lchat/ola/vn/network/OlaNetworkService;->a(JLjava/lang/String;S)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$6;->a:Lchat/ola/vn/message/d;

    invoke-virtual {v0, v2}, Lchat/ola/vn/message/d;->b(B)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$6;->a:Lchat/ola/vn/message/d;

    const/4 v1, 0x5

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/d;->b(B)V

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
