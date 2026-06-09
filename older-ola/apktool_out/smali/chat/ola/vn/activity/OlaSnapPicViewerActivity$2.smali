.class Lchat/ola/vn/activity/OlaSnapPicViewerActivity$2;
.super Ljava/util/TimerTask;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaSnapPicViewerActivity;->B()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaSnapPicViewerActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaSnapPicViewerActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaSnapPicViewerActivity$2;->a:Lchat/ola/vn/activity/OlaSnapPicViewerActivity;

    invoke-direct {p0}, Ljava/util/TimerTask;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-object v2, p0, Lchat/ola/vn/activity/OlaSnapPicViewerActivity$2;->a:Lchat/ola/vn/activity/OlaSnapPicViewerActivity;

    invoke-static {v2}, Lchat/ola/vn/activity/OlaSnapPicViewerActivity;->b(Lchat/ola/vn/activity/OlaSnapPicViewerActivity;)J

    move-result-wide v2

    sub-long v4, v0, v2

    const-wide/16 v0, 0x3e8

    div-long/2addr v4, v0

    long-to-int v0, v4

    if-lez v0, :cond_1

    sget-object v1, Lchat/ola/vn/activity/OlaSnapPicViewerActivity;->e:Lchat/ola/vn/message/t;

    invoke-virtual {v1}, Lchat/ola/vn/message/t;->C()S

    move-result v1

    sub-int/2addr v1, v0

    int-to-long v0, v1

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    if-gtz v4, :cond_0

    sget-object v0, Lchat/ola/vn/activity/OlaSnapPicViewerActivity;->e:Lchat/ola/vn/message/t;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/t;->d(S)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaSnapPicViewerActivity$2;->a:Lchat/ola/vn/activity/OlaSnapPicViewerActivity;

    invoke-virtual {v0}, Lchat/ola/vn/activity/OlaSnapPicViewerActivity;->finish()V

    return-void

    :cond_0
    iget-object v2, p0, Lchat/ola/vn/activity/OlaSnapPicViewerActivity$2;->a:Lchat/ola/vn/activity/OlaSnapPicViewerActivity;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    invoke-static {v2, v3, v4}, Lchat/ola/vn/activity/OlaSnapPicViewerActivity;->a(Lchat/ola/vn/activity/OlaSnapPicViewerActivity;J)J

    iget-object v2, p0, Lchat/ola/vn/activity/OlaSnapPicViewerActivity$2;->a:Lchat/ola/vn/activity/OlaSnapPicViewerActivity;

    iget-object v2, v2, Lchat/ola/vn/activity/OlaSnapPicViewerActivity;->g:Landroid/widget/ProgressBar;

    long-to-int v0, v0

    invoke-virtual {v2, v0}, Landroid/widget/ProgressBar;->setProgress(I)V

    sget-object v1, Lchat/ola/vn/activity/OlaSnapPicViewerActivity;->e:Lchat/ola/vn/message/t;

    int-to-short v0, v0

    invoke-virtual {v1, v0}, Lchat/ola/vn/message/t;->d(S)V

    :cond_1
    return-void
.end method
