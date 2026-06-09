.class Lchat/ola/vn/activity/OlaChatViewActivity$4;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaChatViewActivity;->V()V
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

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$4;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView<",
            "*>;",
            "Landroid/view/View;",
            "IJ)V"
        }
    .end annotation

    const/4 p1, 0x0

    const-wide p4, 0x7fffffffffffffffL

    packed-switch p3, :pswitch_data_0

    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$4;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    goto :goto_1

    :pswitch_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$4;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object p1

    invoke-static {p4, p5}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    :goto_0
    iput-object p2, p1, Lchat/ola/vn/message/f;->J:Ljava/lang/Long;

    goto/16 :goto_2

    :pswitch_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$4;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object p1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide p2

    const-wide/32 p4, 0x5265c00

    add-long v0, p2, p4

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    goto :goto_0

    :pswitch_2
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$4;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object p1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide p2

    const-wide/32 p4, 0x1b77400

    add-long v0, p2, p4

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    goto :goto_0

    :pswitch_3
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$4;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object p1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide p2

    const-wide/32 p4, 0x36ee80

    add-long v0, p2, p4

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    goto :goto_0

    :pswitch_4
    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$4;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object p2

    iget-object p2, p2, Lchat/ola/vn/message/f;->J:Ljava/lang/Long;

    if-eqz p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$4;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object p2

    iget-object p2, p2, Lchat/ola/vn/message/f;->J:Ljava/lang/Long;

    invoke-virtual {p2}, Ljava/lang/Long;->longValue()J

    move-result-wide p2

    cmp-long v0, p2, p4

    if-nez v0, :cond_0

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$4;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    :goto_1
    invoke-static {p2}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object p2

    iput-object p1, p2, Lchat/ola/vn/message/f;->J:Ljava/lang/Long;

    goto :goto_2

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$4;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object p1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide p2

    const-wide/32 p4, 0xdbba0

    add-long v0, p2, p4

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    goto :goto_0

    :goto_2
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$4;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    const/4 p2, 0x1

    invoke-static {p1, p2}, Lchat/ola/vn/activity/OlaChatViewActivity;->b(Lchat/ola/vn/activity/OlaChatViewActivity;Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
