.class public Lchat/ola/vn/activity/OlaBottomTabActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Lchat/ola/vn/f/a;
.implements Lchat/ola/vn/p/f;
.implements Lchat/ola/vn/view/OlaTabViewLayout$a;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/activity/OlaBottomTabActivity$a;
    }
.end annotation


# static fields
.field public static e:Landroid/graphics/drawable/Drawable; = null

.field public static f:Z = false

.field public static g:Z = false

.field private static s:Z = false


# instance fields
.field h:Landroid/app/Dialog;

.field protected i:Landroid/widget/FrameLayout;

.field private j:Lchat/ola/vn/view/OlaTabViewLayout;

.field private k:Landroid/view/LayoutInflater;

.field private l:Ljava/util/Stack;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Stack<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private o:I

.field private p:Landroid/content/BroadcastReceiver;

.field private q:Ljava/lang/String;

.field private r:J


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->q:Ljava/lang/String;

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->r:J

    return-void
.end method

.method public static E()V
    .locals 1

    const/4 v0, 0x0

    sput-object v0, Lchat/ola/vn/activity/OlaBottomTabActivity;->e:Landroid/graphics/drawable/Drawable;

    const/4 v0, 0x0

    sput-boolean v0, Lchat/ola/vn/activity/OlaBottomTabActivity;->f:Z

    return-void
.end method

.method private M()V
    .locals 14

    const-class v5, Lchat/ola/vn/m/e;

    const/4 v1, 0x0

    const v2, 0x7f0f00e0

    const v3, 0x7f080671

    const v4, 0x7f080672

    const/4 v6, 0x0

    move-object v0, p0

    invoke-virtual/range {v0 .. v6}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(IIIILjava/lang/Class;Z)Lchat/ola/vn/view/OlaTabViewLayout$c;

    const-class v12, Lchat/ola/vn/m/l;

    const/16 v8, 0xe

    const v9, 0x7f0f00f7

    const v10, 0x7f080675

    const v11, 0x7f080676

    const/4 v13, 0x0

    move-object v7, p0

    invoke-virtual/range {v7 .. v13}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(IIIILjava/lang/Class;Z)Lchat/ola/vn/view/OlaTabViewLayout$c;

    const-class v5, Lchat/ola/vn/me/c;

    const/4 v1, 0x1

    const v2, 0x7f0f00eb

    const v3, 0x7f08066f

    const v4, 0x7f080670

    invoke-virtual/range {v0 .. v6}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(IIIILjava/lang/Class;Z)Lchat/ola/vn/view/OlaTabViewLayout$c;

    const-class v12, Lchat/ola/vn/m/j;

    const/4 v8, 0x2

    const v9, 0x7f0f00f8

    const v10, 0x7f080677

    const v11, 0x7f080678

    invoke-virtual/range {v7 .. v13}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(IIIILjava/lang/Class;Z)Lchat/ola/vn/view/OlaTabViewLayout$c;

    const-class v5, Lchat/ola/vn/m/d;

    const/4 v1, 0x4

    const v2, 0x7f0f00dc

    const v3, 0x7f080673

    const v4, 0x7f080674

    invoke-virtual/range {v0 .. v6}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(IIIILjava/lang/Class;Z)Lchat/ola/vn/view/OlaTabViewLayout$c;

    move-result-object v0

    const-class v1, Lchat/ola/vn/m/z;

    const/4 v2, 0x1

    const/4 v3, 0x5

    invoke-virtual {p0, v3, v0, v1, v2}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(ILchat/ola/vn/view/OlaTabViewLayout$c;Ljava/lang/Class;Z)V

    const-class v1, Lchat/ola/vn/m/m;

    const/16 v3, 0x8

    invoke-virtual {p0, v3, v0, v1, v2}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(ILchat/ola/vn/view/OlaTabViewLayout$c;Ljava/lang/Class;Z)V

    const-class v1, Lchat/ola/vn/m/k;

    const/4 v2, 0x0

    const/16 v3, 0x9

    invoke-virtual {p0, v3, v0, v1, v2}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(ILchat/ola/vn/view/OlaTabViewLayout$c;Ljava/lang/Class;Z)V

    const-class v1, Lchat/ola/vn/m/b;

    const/16 v3, 0xa

    invoke-virtual {p0, v3, v0, v1, v2}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(ILchat/ola/vn/view/OlaTabViewLayout$c;Ljava/lang/Class;Z)V

    const-class v1, Lchat/ola/vn/m/h;

    const/16 v3, 0xb

    invoke-virtual {p0, v3, v0, v1, v2}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(ILchat/ola/vn/view/OlaTabViewLayout$c;Ljava/lang/Class;Z)V

    const-class v1, Lchat/ola/vn/m/g;

    const/4 v3, 0x3

    invoke-virtual {p0, v3, v0, v1, v2}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(ILchat/ola/vn/view/OlaTabViewLayout$c;Ljava/lang/Class;Z)V

    const-class v1, Lchat/ola/vn/m/i;

    const/16 v3, 0xd

    invoke-virtual {p0, v3, v0, v1, v2}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(ILchat/ola/vn/view/OlaTabViewLayout$c;Ljava/lang/Class;Z)V

    return-void
.end method

.method private N()V
    .locals 6

    const-wide v0, 0x7fffffffffffffffL

    :try_start_0
    sget-wide v2, Lchat/ola/vn/c/x;->a:J

    cmp-long v4, v0, v2

    if-eqz v4, :cond_1

    sget-wide v0, Lchat/ola/vn/c/x;->a:J

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    if-nez v4, :cond_0

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    sput-wide v0, Lchat/ola/vn/c/x;->a:J

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    sget-wide v1, Lchat/ola/vn/c/x;->a:J

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/e;->b(J)V

    return-void

    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    sget-wide v2, Lchat/ola/vn/c/x;->a:J

    const/4 v4, 0x0

    sub-long v4, v0, v2

    const-wide/32 v0, 0xf731400

    cmp-long v2, v4, v0

    if-ltz v2, :cond_1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    sput-wide v0, Lchat/ola/vn/c/x;->a:J

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    sget-wide v1, Lchat/ola/vn/c/x;->a:J

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/e;->b(J)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaBottomTabActivity;)Lchat/ola/vn/view/OlaTabViewLayout;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->j:Lchat/ola/vn/view/OlaTabViewLayout;

    return-object p0
.end method

.method public static a(Landroid/content/Context;I)V
    .locals 1

    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(Landroid/content/Context;ILandroid/os/Bundle;)V

    return-void
.end method

.method public static a(Landroid/content/Context;ILandroid/os/Bundle;)V
    .locals 1

    :try_start_0
    sput p1, Lchat/ola/vn/h;->q:I

    sget-object p1, Lchat/ola/vn/activity/OlaBottomTabActivity;->b_:Lchat/ola/vn/c;

    check-cast p1, Lchat/ola/vn/activity/OlaBottomTabActivity;

    invoke-direct {p1, p2}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(Landroid/os/Bundle;)V

    invoke-virtual {p1}, Lchat/ola/vn/activity/OlaBottomTabActivity;->J()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    if-nez p0, :cond_0

    return-void

    :cond_0
    :try_start_1
    move-object p1, p0

    check-cast p1, Lchat/ola/vn/c;

    const-class v0, Lchat/ola/vn/activity/OlaBottomTabActivity;

    invoke-virtual {p1, v0, p2}, Lchat/ola/vn/c;->a(Ljava/lang/Class;Landroid/os/Bundle;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    return-void

    :catch_1
    :try_start_2
    new-instance p1, Landroid/content/Intent;

    const-class v0, Lchat/ola/vn/activity/OlaBottomTabActivity;

    invoke-direct {p1, p0, v0}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    if-eqz p2, :cond_1

    invoke-virtual {p1, p2}, Landroid/content/Intent;->putExtras(Landroid/os/Bundle;)Landroid/content/Intent;

    :cond_1
    invoke-virtual {p0, p1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    return-void

    :catch_2
    new-instance p1, Landroid/content/Intent;

    const-class v0, Lchat/ola/vn/activity/OlaBottomTabActivity;

    invoke-direct {p1, p0, v0}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    if-eqz p2, :cond_2

    invoke-virtual {p1, p2}, Landroid/content/Intent;->putExtras(Landroid/os/Bundle;)Landroid/content/Intent;

    :cond_2
    const/high16 p2, 0x10000000

    invoke-virtual {p1, p2}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    invoke-virtual {p0, p1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    return-void
.end method

.method private a(Landroid/content/Intent;)V
    .locals 8

    :try_start_0
    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    const-string v1, "chat.ola.vn.ACTION_REFRESH_ME"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_1

    invoke-static {}, Lchat/ola/vn/me/c;->c()Lchat/ola/vn/me/c;

    move-result-object p1

    if-eqz p1, :cond_0

    invoke-static {}, Lchat/ola/vn/me/c;->c()Lchat/ola/vn/me/c;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/me/c;->d()V

    return-void

    :cond_0
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {p0, p1, v2}, Lchat/ola/vn/me/c;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;)V

    return-void

    :cond_1
    const-string v1, "chat.ola.vn.ACTION_REFRESH_BIN"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-static {p0}, Lchat/ola/vn/me/OlaDiaryActivity;->a(Landroid/content/Context;)V

    return-void

    :cond_2
    const-string v1, "chat.ola.vn.ACTION_VIEW_ME"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    const-wide/16 v3, 0x0

    const/4 v5, -0x1

    if-eqz v1, :cond_5

    const-string v0, "_me_page_id"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "_index"

    invoke-virtual {p1, v1, v5}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v1

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v6

    if-nez v6, :cond_3

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {p0, p1, v0}, Lchat/ola/vn/me/c;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;)V

    goto :goto_0

    :cond_3
    const-string v0, "_me_entry_id"

    invoke-virtual {p1, v0, v3, v4}, Landroid/content/Intent;->getLongExtra(Ljava/lang/String;J)J

    move-result-wide v6

    cmp-long p1, v6, v3

    if-eqz p1, :cond_4

    invoke-static {p0, v6, v7}, Lchat/ola/vn/me/OlaMeCommentActivity;->a(Landroid/content/Context;J)V

    goto :goto_0

    :cond_4
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {p0, p1, v2}, Lchat/ola/vn/me/c;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;)V

    :goto_0
    if-eq v1, v5, :cond_a

    const-string p1, "notification"

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaBottomTabActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/app/NotificationManager;

    invoke-virtual {p1, v1}, Landroid/app/NotificationManager;->cancel(I)V

    return-void

    :cond_5
    const-string v1, "chat.ola.vn.ACTION_VIEW_LIKED_ME"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_7

    const-string v0, "_index"

    invoke-virtual {p1, v0, v5}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v0

    const-string v1, "_me_entry_id"

    invoke-virtual {p1, v1, v3, v4}, Landroid/content/Intent;->getLongExtra(Ljava/lang/String;J)J

    move-result-wide v6

    cmp-long p1, v6, v3

    if-eqz p1, :cond_6

    invoke-static {p0, v6, v7}, Lchat/ola/vn/me/OlaMeCommentActivity;->a(Landroid/content/Context;J)V

    goto :goto_1

    :cond_6
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {p0, p1, v2}, Lchat/ola/vn/me/c;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;)V

    :goto_1
    if-eq v0, v5, :cond_a

    const-string p1, "notification"

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaBottomTabActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/app/NotificationManager;

    invoke-virtual {p1, v0}, Landroid/app/NotificationManager;->cancel(I)V

    return-void

    :cond_7
    const-string v1, "chat.ola.vn.ACTION_VIEW_FOLLOW_ME"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_8

    const-string v0, "_me_page_id"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "_index"

    invoke-virtual {p1, v1, v5}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {p0, v1, v0}, Lchat/ola/vn/me/c;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_2

    :catch_0
    move-exception v0

    :try_start_2
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :goto_2
    if-eq p1, v5, :cond_a

    const-string v0, "notification"

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    invoke-virtual {v0, p1}, Landroid/app/NotificationManager;->cancel(I)V

    return-void

    :cond_8
    const-string p1, "chat.ola.vn.ACTION_SHOW_CONVERSATION"

    invoke-static {v0, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_9

    invoke-static {p0}, Lchat/ola/vn/m/e;->b(Landroid/content/Context;)V

    invoke-static {p0}, Lchat/ola/vn/util/c/b;->a(Landroid/content/Context;)V

    return-void

    :cond_9
    const-string p1, "chat.ola.vn.ACTION_VIEW_NOTE"

    invoke-static {v0, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_a

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "note/"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, p1}, Lchat/ola/vn/m/j;->a(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_a
    return-void
.end method

.method private a(Landroid/os/Bundle;)V
    .locals 2

    :try_start_0
    sget v0, Lchat/ola/vn/h;->q:I

    if-gez v0, :cond_0

    const/4 v0, 0x0

    sput v0, Lchat/ola/vn/h;->q:I

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "fragment_"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget v1, Lchat/ola/vn/h;->q:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    :try_start_1
    iget-object v1, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->j:Lchat/ola/vn/view/OlaTabViewLayout;

    invoke-virtual {v1}, Lchat/ola/vn/view/OlaTabViewLayout;->getTabTag()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_3

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->j:Lchat/ola/vn/view/OlaTabViewLayout;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaTabViewLayout;->getCurrentFragmentTab()Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/m/f;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_2

    if-eqz p1, :cond_2

    :try_start_2
    invoke-virtual {v0}, Lchat/ola/vn/m/f;->getArguments()Landroid/os/Bundle;

    move-result-object v1

    if-nez v1, :cond_1

    invoke-virtual {v0, p1}, Lchat/ola/vn/m/f;->setArguments(Landroid/os/Bundle;)V

    goto :goto_0

    :cond_1
    invoke-virtual {v0}, Lchat/ola/vn/m/f;->getArguments()Landroid/os/Bundle;

    move-result-object v1

    invoke-virtual {v1, p1}, Landroid/os/Bundle;->putAll(Landroid/os/Bundle;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    :catch_0
    :cond_2
    :goto_0
    :try_start_3
    invoke-virtual {v0, p1}, Lchat/ola/vn/m/f;->d(Landroid/os/Bundle;)V

    goto :goto_1

    :cond_3
    iget-object v1, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->j:Lchat/ola/vn/view/OlaTabViewLayout;

    invoke-virtual {v1, v0, p1}, Lchat/ola/vn/view/OlaTabViewLayout;->a(Ljava/lang/String;Landroid/os/Bundle;)Landroid/support/v4/app/Fragment;
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_1
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    :catch_1
    :goto_1
    :try_start_4
    invoke-static {}, Lchat/ola/vn/a;->a()Lchat/ola/vn/a;

    move-result-object p1

    sget v0, Lchat/ola/vn/h;->q:I

    invoke-virtual {p1, v0}, Lchat/ola/vn/a;->a(I)V

    sget p1, Lchat/ola/vn/h;->q:I

    iput p1, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->o:I
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    :catch_2
    return-void
.end method

.method private a(Lchat/ola/vn/entry/e;)Z
    .locals 4

    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p1}, Lchat/ola/vn/entry/e;->d()I

    move-result v1

    const v2, 0x7f0f00f1

    const/4 v3, 0x1

    if-eq v1, v2, :cond_0

    invoke-virtual {p1, p0}, Lchat/ola/vn/entry/e;->a(Landroid/content/Context;)Z

    move-result p1

    if-eqz p1, :cond_1

    return v3

    :cond_0
    invoke-static {p0}, Lchat/ola/vn/m/k;->a(Landroid/content/Context;)V

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v3

    :catch_0
    :cond_1
    return v0
.end method

.method public static h(I)V
    .locals 2

    :try_start_0
    invoke-static {}, Lchat/ola/vn/activity/OlaBottomTabActivity;->c()Lchat/ola/vn/c;

    move-result-object v0

    if-eqz v0, :cond_0

    instance-of v1, v0, Lchat/ola/vn/activity/OlaBottomTabActivity;

    if-eqz v1, :cond_0

    check-cast v0, Lchat/ola/vn/activity/OlaBottomTabActivity;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaBottomTabActivity;->l:Ljava/util/Stack;

    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/util/Stack;->remove(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p0

    invoke-virtual {p0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    return-void
.end method


# virtual methods
.method public C()V
    .locals 0

    return-void
.end method

.method protected F()V
    .locals 3
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    sget-object v0, Lchat/ola/vn/activity/OlaBottomTabActivity;->e:Landroid/graphics/drawable/Drawable;

    if-nez v0, :cond_1

    sget-boolean v0, Lchat/ola/vn/activity/OlaBottomTabActivity;->f:Z

    if-nez v0, :cond_1

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    new-instance v1, Landroid/graphics/drawable/ColorDrawable;

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->f()I

    move-result v2

    invoke-direct {v1, v2}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {v0, v1}, Landroid/view/Window;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    :try_start_0
    new-instance v0, Lchat/ola/vn/activity/OlaBottomTabActivity$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaBottomTabActivity$1;-><init>(Lchat/ola/vn/activity/OlaBottomTabActivity;)V

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_0

    sget-object v1, Lchat/ola/vn/h;->R:Ljava/util/concurrent/ExecutorService;

    new-array v2, v2, [Ljava/lang/Void;

    invoke-virtual {v0, v1, v2}, Landroid/os/AsyncTask;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    goto :goto_0

    :cond_0
    new-array v1, v2, [Ljava/lang/Void;

    invoke-virtual {v0, v1}, Landroid/os/AsyncTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    :goto_0
    sget-object v0, Lchat/ola/vn/activity/OlaBottomTabActivity;->e:Landroid/graphics/drawable/Drawable;

    if-nez v0, :cond_2

    :try_start_1
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    new-instance v1, Landroid/graphics/drawable/ColorDrawable;

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->f()I

    move-result v2

    invoke-direct {v1, v2}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {v0, v1}, Landroid/view/Window;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    return-void

    :cond_2
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/activity/OlaBottomTabActivity;->e:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v0, v1}, Landroid/view/Window;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    :catch_1
    return-void
.end method

.method public G()V
    .locals 6

    :try_start_0
    const-string v0, "fragment_14"

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->j:Lchat/ola/vn/view/OlaTabViewLayout;

    invoke-virtual {v1, v0}, Lchat/ola/vn/view/OlaTabViewLayout;->b(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/activity/OlaBottomTabActivity$a;

    sget-object v1, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v1}, Lchat/ola/vn/r/a/f;->p()Lchat/ola/vn/entity/s;

    move-result-object v1

    const/4 v2, 0x0

    const/4 v3, 0x0

    if-eqz v1, :cond_0

    sget-object v1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    sget-object v4, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v4}, Lchat/ola/vn/r/a/f;->p()Lchat/ola/vn/entity/s;

    move-result-object v4

    invoke-virtual {v4}, Lchat/ola/vn/entity/s;->c()J

    move-result-wide v4

    invoke-virtual {v1, v4, v5}, Lchat/ola/vn/message/g;->a(J)Lchat/ola/vn/message/f;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->z()I

    move-result v1

    if-lez v1, :cond_0

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/activity/OlaBottomTabActivity$a;->a(Ljava/lang/String;)V

    return-void

    :cond_0
    invoke-virtual {v0, v3, v2}, Lchat/ola/vn/activity/OlaBottomTabActivity$a;->a(Ljava/lang/String;Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    return-void
.end method

.method public H()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public I()V
    .locals 1

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0}, Lchat/ola/vn/message/g;->q()I

    move-result v0

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->e(I)V

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->u()I

    move-result v0

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->f(I)V

    sget-object v0, Lchat/ola/vn/h;->v:Lchat/ola/vn/r/a/c;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/c;->f()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->f(Ljava/lang/String;)V

    return-void
.end method

.method public J()V
    .locals 1

    iget v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->o:I

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->g(I)V

    return-void
.end method

.method public K()Z
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->l:Ljava/util/Stack;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->l:Ljava/util/Stack;

    iget v2, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->o:I

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/util/Stack;->remove(Ljava/lang/Object;)Z

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->l:Ljava/util/Stack;

    invoke-virtual {v0}, Ljava/util/Stack;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    return v1

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->l:Ljava/util/Stack;

    invoke-virtual {v0}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    sput v0, Lchat/ola/vn/h;->q:I

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(Landroid/os/Bundle;)V

    const/4 v0, 0x1

    return v0
.end method

.method public L()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->o:I

    return v0
.end method

.method public a(IIIILjava/lang/Class;Z)Lchat/ola/vn/view/OlaTabViewLayout$c;
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(IIII",
            "Ljava/lang/Class<",
            "*>;Z)",
            "Lchat/ola/vn/view/OlaTabViewLayout$c;"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->k:Landroid/view/LayoutInflater;

    const v1, 0x7f0b01bd

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v6

    new-instance v0, Lchat/ola/vn/activity/OlaBottomTabActivity$a;

    invoke-direct {v0, v6}, Lchat/ola/vn/activity/OlaBottomTabActivity$a;-><init>(Landroid/view/View;)V

    invoke-virtual {v0, p2, p3}, Lchat/ola/vn/activity/OlaBottomTabActivity$a;->a(II)V

    iget-object v3, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->j:Lchat/ola/vn/view/OlaTabViewLayout;

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "fragment_"

    invoke-virtual {p2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    new-instance v8, Lchat/ola/vn/activity/OlaBottomTabActivity$2;

    invoke-direct {v8, p0, v0, p4, p3}, Lchat/ola/vn/activity/OlaBottomTabActivity$2;-><init>(Lchat/ola/vn/activity/OlaBottomTabActivity;Lchat/ola/vn/activity/OlaBottomTabActivity$a;II)V

    move-object v5, p5

    move v7, p6

    invoke-virtual/range {v3 .. v8}, Lchat/ola/vn/view/OlaTabViewLayout;->a(Ljava/lang/String;Ljava/lang/Class;Landroid/view/View;ZLchat/ola/vn/view/OlaTabViewLayout$b;)Lchat/ola/vn/view/OlaTabViewLayout$c;

    move-result-object p1

    return-object p1
.end method

.method protected a()V
    .locals 6

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->F()V

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0, p0}, Lchat/ola/vn/message/g;->a(Lchat/ola/vn/p/f;)V

    :cond_0
    :try_start_0
    sget v0, Lchat/ola/vn/h;->q:I

    if-ltz v0, :cond_1

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->J()V

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object v0

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(Landroid/os/Bundle;)V

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->I()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    new-instance v0, Lchat/ola/vn/activity/OlaBottomTabActivity$3;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaBottomTabActivity$3;-><init>(Lchat/ola/vn/activity/OlaBottomTabActivity;)V

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->p:Landroid/content/BroadcastReceiver;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->p:Landroid/content/BroadcastReceiver;

    new-instance v1, Landroid/content/IntentFilter;

    const-string v2, "chat.ola.vn.ACTION_CHANGE_BALANCE"

    invoke-direct {v1, v2}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/activity/OlaBottomTabActivity;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->N()V

    :try_start_2
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->G()V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->r:J

    const/4 v4, 0x0

    sub-long v4, v0, v2

    const-wide/32 v0, 0x927c0

    cmp-long v2, v4, v0

    if-lez v2, :cond_2

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0}, Lchat/ola/vn/message/g;->q()I

    move-result v0

    if-lez v0, :cond_3

    invoke-static {p0}, Lchat/ola/vn/m/e;->b(Landroid/content/Context;)V

    goto :goto_0

    :cond_2
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->r:J
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :catch_2
    :cond_3
    :goto_0
    sget-boolean v0, Lchat/ola/vn/activity/OlaBottomTabActivity;->g:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_4

    sput-boolean v1, Lchat/ola/vn/activity/OlaBottomTabActivity;->g:Z

    new-instance v0, Lchat/ola/vn/activity/OlaBottomTabActivity$4;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaBottomTabActivity$4;-><init>(Lchat/ola/vn/activity/OlaBottomTabActivity;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void

    :cond_4
    sget-boolean v0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->e:Z

    if-eqz v0, :cond_5

    invoke-static {}, Lchat/ola/vn/h;->b()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Lchat/ola/vn/activity/OlaChangePasswordActivity;->a(Landroid/content/Context;Ljava/lang/String;)V

    sput-boolean v1, Lchat/ola/vn/tutorial/OlaTutorialActivity;->e:Z

    return-void

    :cond_5
    :try_start_3
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x17

    const/4 v3, 0x1

    if-lt v0, v2, :cond_6

    const-string v0, "android.permission.READ_CONTACTS"

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->checkSelfPermission(Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_6

    sget-boolean v0, Lchat/ola/vn/activity/OlaBottomTabActivity;->s:Z

    if-nez v0, :cond_7

    sput-boolean v3, Lchat/ola/vn/activity/OlaBottomTabActivity;->s:Z

    new-array v0, v3, [Ljava/lang/String;

    const-string v2, "android.permission.READ_CONTACTS"

    aput-object v2, v0, v1

    const/16 v1, 0x64

    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/activity/OlaBottomTabActivity;->requestPermissions([Ljava/lang/String;I)V

    return-void

    :cond_6
    new-instance v0, Lchat/ola/vn/v/d;

    invoke-direct {v0}, Lchat/ola/vn/v/d;-><init>()V

    new-array v2, v3, [Landroid/content/Context;

    aput-object p0, v2, v1

    invoke-virtual {v0, v2}, Lchat/ola/vn/v/d;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_3

    :catch_3
    :cond_7
    return-void
.end method

.method public a(ILchat/ola/vn/view/OlaTabViewLayout$c;Ljava/lang/Class;Z)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Lchat/ola/vn/view/OlaTabViewLayout$c;",
            "Ljava/lang/Class<",
            "*>;Z)V"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->j:Lchat/ola/vn/view/OlaTabViewLayout;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "fragment_"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const/4 v1, 0x0

    invoke-virtual {v0, p1, p3, v1, p4}, Lchat/ola/vn/view/OlaTabViewLayout;->a(Ljava/lang/String;Ljava/lang/Class;Landroid/view/View;Z)Lchat/ola/vn/view/OlaTabViewLayout$c;

    move-result-object p1

    if-eqz p1, :cond_0

    invoke-virtual {p1, p2}, Lchat/ola/vn/view/OlaTabViewLayout$c;->a(Lchat/ola/vn/view/OlaTabViewLayout$c;)V

    :cond_0
    return-void
.end method

.method public a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V
    .locals 7

    invoke-super/range {p0 .. p5}, Lchat/ola/vn/c;->a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->j:Lchat/ola/vn/view/OlaTabViewLayout;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaTabViewLayout;->getCurrentFragmentTab()Landroid/support/v4/app/Fragment;

    move-result-object v0

    move-object v1, v0

    check-cast v1, Lchat/ola/vn/m/f;

    move v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    move v6, p5

    invoke-virtual/range {v1 .. v6}, Lchat/ola/vn/m/f;->a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(JLjava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;S)V
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(J",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;S)V"
        }
    .end annotation

    move-object v0, p0

    :try_start_0
    iget-object v1, v0, Lchat/ola/vn/activity/OlaBottomTabActivity;->j:Lchat/ola/vn/view/OlaTabViewLayout;

    invoke-virtual {v1}, Lchat/ola/vn/view/OlaTabViewLayout;->getCurrentFragmentTab()Landroid/support/v4/app/Fragment;

    move-result-object v1

    move-object v2, v1

    check-cast v2, Lchat/ola/vn/m/f;

    move-wide v3, p1

    move-object v5, p3

    move-object v6, p4

    move-object v7, p5

    move-object/from16 v8, p6

    move/from16 v9, p7

    invoke-virtual/range {v2 .. v9}, Lchat/ola/vn/m/f;->a(JLjava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Lchat/ola/vn/entity/ag;S)V
    .locals 1

    :try_start_0
    invoke-super {p0, p1, p2}, Lchat/ola/vn/c;->a(Lchat/ola/vn/entity/ag;S)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->j:Lchat/ola/vn/view/OlaTabViewLayout;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaTabViewLayout;->getCurrentFragmentTab()Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/m/f;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/m/f;->a(Lchat/ola/vn/entity/ag;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Lchat/ola/vn/message/d;BB)V
    .locals 0

    return-void
.end method

.method public a(Lchat/ola/vn/message/f;ILjava/lang/String;Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/message/f;",
            "I",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/d;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public a(Lchat/ola/vn/message/f;Lchat/ola/vn/message/d;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->j:Lchat/ola/vn/view/OlaTabViewLayout;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaTabViewLayout;->getCurrentFragmentTab()Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/m/l;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/m/l;->a(Lchat/ola/vn/message/f;Lchat/ola/vn/message/d;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Lchat/ola/vn/message/f;Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/message/f;",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/d;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public a(Ljava/lang/Short;I)V
    .locals 1

    :try_start_0
    invoke-super {p0, p1, p2}, Lchat/ola/vn/c;->a(Ljava/lang/Short;I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->j:Lchat/ola/vn/view/OlaTabViewLayout;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaTabViewLayout;->getCurrentFragmentTab()Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/m/f;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/m/f;->a(Ljava/lang/Short;I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Ljava/util/List;S)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/s;",
            ">;S)V"
        }
    .end annotation

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->j:Lchat/ola/vn/view/OlaTabViewLayout;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaTabViewLayout;->getCurrentFragmentTab()Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/m/f;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/m/f;->a(Ljava/util/List;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Lchat/ola/vn/view/OlaTabViewLayout$c;I)Z
    .locals 3

    if-eqz p1, :cond_1

    :try_start_0
    invoke-virtual {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->a()Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_1

    const-string p2, "fragment_"

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result p2

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    invoke-virtual {p1, p2, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    sget p2, Lchat/ola/vn/h;->q:I

    if-ne p2, p1, :cond_1

    const/4 p2, 0x1

    if-eq p1, p2, :cond_0

    goto :goto_0

    :cond_0
    const p1, 0x7f0f05ad

    const-wide/16 v0, 0x1388

    const/4 v2, 0x0

    invoke-static {p0, p1, v0, v1, v2}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IJLjava/lang/Runnable;)Lchat/ola/vn/i/c;

    move-result-object p1

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v1, Lchat/ola/vn/activity/OlaBottomTabActivity$5;

    invoke-direct {v1, p0, p1}, Lchat/ola/vn/activity/OlaBottomTabActivity$5;-><init>(Lchat/ola/vn/activity/OlaBottomTabActivity;Lchat/ola/vn/i/c;)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/p/p;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return p2

    :catch_0
    :cond_1
    :goto_0
    const/4 p1, 0x0

    return p1
.end method

.method public a_()V
    .locals 0

    return-void
.end method

.method public b(Lchat/ola/vn/message/f;)V
    .locals 0

    return-void
.end method

.method public b(Lchat/ola/vn/message/f;Lchat/ola/vn/message/d;)V
    .locals 0

    return-void
.end method

.method public b(Ljava/lang/Short;I)V
    .locals 0

    return-void
.end method

.method public b(Lchat/ola/vn/view/OlaTabViewLayout$c;I)Z
    .locals 3

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->I()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    const/4 p2, 0x0

    if-eqz p1, :cond_6

    :try_start_1
    invoke-virtual {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->a()Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_6

    const-string v0, "fragment_"

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    invoke-virtual {p1, v0, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    sget v0, Lchat/ola/vn/h;->q:I

    if-ne v0, p1, :cond_0

    if-nez p1, :cond_0

    invoke-static {p0}, Lchat/ola/vn/m/e;->a(Landroid/content/Context;)V

    goto :goto_0

    :cond_0
    const/16 v0, 0xe

    if-ne p1, v0, :cond_1

    invoke-static {p0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->a(Landroid/content/Context;)V

    goto :goto_0

    :cond_1
    const/4 v0, 0x2

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-ne p1, v0, :cond_2

    invoke-static {p0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->a(Landroid/content/Context;)V

    sput-boolean p2, Lchat/ola/vn/m/j;->d:Z

    sget v0, Lchat/ola/vn/h;->q:I

    if-ne v0, p1, :cond_5

    invoke-static {p0, v1}, Lchat/ola/vn/m/j;->a(Landroid/content/Context;Ljava/lang/String;)V

    return v2

    :cond_2
    if-ne p1, v2, :cond_3

    invoke-static {p0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->a(Landroid/content/Context;)V

    sget v0, Lchat/ola/vn/h;->q:I

    if-ne v0, p1, :cond_5

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {p0, p1, v1}, Lchat/ola/vn/me/c;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;)V

    return v2

    :cond_3
    const/4 v0, 0x4

    if-ne p1, v0, :cond_4

    invoke-static {p0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->a(Landroid/content/Context;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_2

    :try_start_2
    sget-object v0, Lchat/ola/vn/h;->v:Lchat/ola/vn/r/a/c;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/c;->d()Lchat/ola/vn/entry/e;

    move-result-object v0

    if-eqz v0, :cond_5

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(Lchat/ola/vn/entry/e;)Z

    move-result v0
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    if-eqz v0, :cond_5

    return v2

    :cond_4
    :try_start_3
    sget v0, Lchat/ola/vn/h;->q:I

    if-ne v0, p1, :cond_5

    packed-switch p1, :pswitch_data_0

    :pswitch_0
    goto :goto_0

    :pswitch_1
    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaBottomTabActivity;->d(I)V

    return v2

    :catch_1
    :cond_5
    :goto_0
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->J()V

    iput p1, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->o:I

    iget p1, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->o:I

    sput p1, Lchat/ola/vn/h;->q:I

    invoke-static {}, Lchat/ola/vn/a;->a()Lchat/ola/vn/a;

    move-result-object p1

    iget v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->o:I

    invoke-virtual {p1, v0}, Lchat/ola/vn/a;->a(I)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    :catch_2
    :cond_6
    return p2

    nop

    :pswitch_data_0
    .packed-switch 0x5
        :pswitch_1
        :pswitch_1
        :pswitch_1
        :pswitch_1
        :pswitch_1
        :pswitch_1
        :pswitch_1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method public c(I)V
    .locals 0

    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p1}, Lchat/ola/vn/message/g;->q()I

    move-result p1

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaBottomTabActivity;->e(I)V

    return-void
.end method

.method public c(Lchat/ola/vn/message/f;)V
    .locals 0

    return-void
.end method

.method public c(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public c(Z)V
    .locals 0

    return-void
.end method

.method public d(I)V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->j:Lchat/ola/vn/view/OlaTabViewLayout;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "fragment_"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaTabViewLayout;->a(Ljava/lang/String;)V

    const/4 v0, 0x4

    invoke-static {p0, v0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(Landroid/content/Context;I)V

    invoke-static {p1}, Lchat/ola/vn/activity/OlaBottomTabActivity;->h(I)V

    return-void
.end method

.method public d(Lchat/ola/vn/message/f;)V
    .locals 0

    return-void
.end method

.method public e(I)V
    .locals 3

    const/4 v0, 0x0

    :try_start_0
    const-string v1, "fragment_0"
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    iget-object v2, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->j:Lchat/ola/vn/view/OlaTabViewLayout;

    invoke-virtual {v2, v1}, Lchat/ola/vn/view/OlaTabViewLayout;->b(Ljava/lang/String;)Landroid/view/View;

    move-result-object v2

    if-eqz v2, :cond_1

    invoke-virtual {v2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/activity/OlaBottomTabActivity$a;

    if-lez p1, :cond_0

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v2, p1}, Lchat/ola/vn/activity/OlaBottomTabActivity$a;->a(Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    invoke-virtual {v2, v0}, Lchat/ola/vn/activity/OlaBottomTabActivity$a;->a(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    :catch_0
    move-object v1, v0

    :catch_1
    :cond_1
    :goto_0
    :try_start_2
    iget p1, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->o:I

    if-nez p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->j:Lchat/ola/vn/view/OlaTabViewLayout;

    invoke-virtual {p1, v1}, Lchat/ola/vn/view/OlaTabViewLayout;->c(Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/m/e;

    invoke-virtual {p1}, Lchat/ola/vn/m/e;->e()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :catch_2
    :cond_2
    return-void
.end method

.method public e(Lchat/ola/vn/message/f;)V
    .locals 0

    return-void
.end method

.method public f(I)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->j:Lchat/ola/vn/view/OlaTabViewLayout;

    const-string v1, "fragment_1"

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaTabViewLayout;->b(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/activity/OlaBottomTabActivity$a;

    if-lez p1, :cond_0

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lchat/ola/vn/activity/OlaBottomTabActivity$a;->a(Ljava/lang/String;)V

    return-void

    :cond_0
    const/4 p1, 0x0

    const/4 v1, 0x0

    invoke-virtual {v0, p1, v1}, Lchat/ola/vn/activity/OlaBottomTabActivity$a;->a(Ljava/lang/String;Z)V

    :cond_1
    return-void
.end method

.method public f(Lchat/ola/vn/message/f;)V
    .locals 0

    return-void
.end method

.method public f(Ljava/lang/String;)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->j:Lchat/ola/vn/view/OlaTabViewLayout;

    const-string v1, "fragment_4"

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaTabViewLayout;->b(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/activity/OlaBottomTabActivity$a;

    const/4 v1, 0x0

    invoke-virtual {v0, p1, v1}, Lchat/ola/vn/activity/OlaBottomTabActivity$a;->a(Ljava/lang/String;Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public g(I)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->l:Ljava/util/Stack;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/Stack;

    invoke-direct {v0}, Ljava/util/Stack;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->l:Ljava/util/Stack;

    :cond_0
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->l:Ljava/util/Stack;

    invoke-virtual {v0, p1}, Ljava/util/Stack;->remove(Ljava/lang/Object;)Z

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->l:Ljava/util/Stack;

    invoke-virtual {v0, p1}, Ljava/util/Stack;->push(Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method public g(Lchat/ola/vn/message/f;)Z
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method public i_()Ljava/lang/String;
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->q:Ljava/lang/String;

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "chat.ola.vn.activity.BottomTabActivity"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->q:Ljava/lang/String;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->q:Ljava/lang/String;

    return-object v0
.end method

.method public j()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->j:Lchat/ola/vn/view/OlaTabViewLayout;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaTabViewLayout;->getCurrentFragmentTab()Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/m/f;

    invoke-virtual {v0}, Lchat/ola/vn/m/f;->d_()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onBackPressed()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->j:Lchat/ola/vn/view/OlaTabViewLayout;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaTabViewLayout;->getCurrentFragmentTab()Landroid/support/v4/app/Fragment;

    move-result-object v0

    if-eqz v0, :cond_0

    instance-of v1, v0, Lchat/ola/vn/m/f;

    if-eqz v1, :cond_0

    check-cast v0, Lchat/ola/vn/m/f;

    invoke-virtual {v0}, Lchat/ola/vn/m/f;->g_()Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->K()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-super {p0}, Lchat/ola/vn/c;->onBackPressed()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b01be

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaBottomTabActivity;->setContentView(I)V

    const p1, 0x7f090097

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaBottomTabActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/FrameLayout;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->i:Landroid/widget/FrameLayout;

    const p1, 0x7f090326

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaBottomTabActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaTabViewLayout;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->j:Lchat/ola/vn/view/OlaTabViewLayout;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->j:Lchat/ola/vn/view/OlaTabViewLayout;

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->getSupportFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaTabViewLayout;->setUpTabHost(Landroid/support/v4/app/FragmentManager;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->j:Lchat/ola/vn/view/OlaTabViewLayout;

    invoke-virtual {p1, p0}, Lchat/ola/vn/view/OlaTabViewLayout;->setOnTabChangeListener(Lchat/ola/vn/view/OlaTabViewLayout$a;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->j:Lchat/ola/vn/view/OlaTabViewLayout;

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f070139

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaTabViewLayout;->setTabHostHeight(I)V

    invoke-static {p0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->k:Landroid/view/LayoutInflater;

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->M()V

    sget p1, Lchat/ola/vn/h;->q:I

    if-gez p1, :cond_0

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/e;->h()I

    move-result p1

    sput p1, Lchat/ola/vn/h;->q:I

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(Landroid/content/Intent;)V

    return-void
.end method

.method protected onDestroy()V
    .locals 2

    :try_start_0
    invoke-super {p0}, Lchat/ola/vn/c;->onDestroy()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    invoke-static {}, Lchat/ola/vn/a;->a()Lchat/ola/vn/a;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/a;->a(I)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    return-void

    :catch_1
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public onKeyDown(ILandroid/view/KeyEvent;)Z
    .locals 3

    const/16 v0, 0x52

    if-ne p1, v0, :cond_2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->j:Lchat/ola/vn/view/OlaTabViewLayout;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaTabViewLayout;->getCurrentFragmentTab()Landroid/support/v4/app/Fragment;

    move-result-object v0

    const/4 v1, 0x1

    if-eqz v0, :cond_1

    instance-of v2, v0, Lchat/ola/vn/m/f;

    if-eqz v2, :cond_1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->h:Landroid/app/Dialog;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->h:Landroid/app/Dialog;

    invoke-virtual {v2}, Landroid/app/Dialog;->isShowing()Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->h:Landroid/app/Dialog;

    invoke-virtual {v0}, Landroid/app/Dialog;->dismiss()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->h:Landroid/app/Dialog;

    return v1

    :cond_0
    check-cast v0, Lchat/ola/vn/m/f;

    invoke-virtual {v0}, Lchat/ola/vn/m/f;->h_()Landroid/app/Dialog;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->h:Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_1
    return v1

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_2
    invoke-super {p0, p1, p2}, Lchat/ola/vn/c;->onKeyDown(ILandroid/view/KeyEvent;)Z

    move-result p1

    return p1
.end method

.method protected onNewIntent(Landroid/content/Intent;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onNewIntent(Landroid/content/Intent;)V

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(Landroid/content/Intent;)V

    return-void
.end method

.method protected onPause()V
    .locals 2

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0, p0}, Lchat/ola/vn/message/g;->b(Lchat/ola/vn/p/f;)V

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->p:Landroid/content/BroadcastReceiver;

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-super {p0}, Lchat/ola/vn/c;->onPause()V

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    sget v1, Lchat/ola/vn/h;->q:I

    invoke-virtual {v0, v1}, Lchat/ola/vn/e;->e(I)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->r:J

    return-void
.end method

.method public onRequestPermissionsResult(I[Ljava/lang/String;[I)V
    .locals 0

    :try_start_0
    invoke-super {p0, p1, p2, p3}, Lchat/ola/vn/c;->onRequestPermissionsResult(I[Ljava/lang/String;[I)V

    const/16 p2, 0x64

    if-ne p1, p2, :cond_0

    const/4 p1, 0x0

    aget p2, p3, p1

    if-nez p2, :cond_0

    new-instance p2, Lchat/ola/vn/v/d;

    invoke-direct {p2}, Lchat/ola/vn/v/d;-><init>()V

    const/4 p3, 0x1

    new-array p3, p3, [Landroid/content/Context;

    aput-object p0, p3, p1

    invoke-virtual {p2, p3}, Lchat/ola/vn/v/d;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public z()Landroid/widget/FrameLayout;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity;->i:Landroid/widget/FrameLayout;

    return-object v0
.end method
