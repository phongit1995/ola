.class final Lchat/ola/vn/util/c/c$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/util/c/c;->a(Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/app/NotificationManager;


# direct methods
.method constructor <init>(Landroid/app/NotificationManager;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/util/c/c$1;->a:Landroid/app/NotificationManager;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/util/c/c$1;->a:Landroid/app/NotificationManager;

    const/16 v1, 0x69

    invoke-virtual {v0, v1}, Landroid/app/NotificationManager;->cancel(I)V

    return-void
.end method
