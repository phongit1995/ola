.class Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$5;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->updateResendView()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;

.field final synthetic val$resendButton:Landroid/widget/Button;

.field final synthetic val$timeUntilResend:J


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;JLandroid/widget/Button;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$5;->this$0:Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;

    iput-wide p2, p0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$5;->val$timeUntilResend:J

    iput-object p4, p0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$5;->val$resendButton:Landroid/widget/Button;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$5;->this$0:Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->isAdded()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    sget-object v0, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    iget-wide v1, p0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$5;->val$timeUntilResend:J

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    sub-long v5, v1, v3

    invoke-virtual {v0, v5, v6}, Ljava/util/concurrent/TimeUnit;->toSeconds(J)J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    const/4 v2, 0x1

    if-lez v4, :cond_1

    iget-object v3, p0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$5;->val$resendButton:Landroid/widget/Button;

    iget-object v4, p0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$5;->this$0:Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;

    sget v5, Lcom/facebook/accountkit/R$string;->com_accountkit_button_resend_code_in:I

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    const/4 v1, 0x0

    aput-object v0, v2, v1

    invoke-virtual {v4, v5, v2}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$5;->this$0:Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;

    invoke-static {v0}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->access$300(Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;)Landroid/os/Handler;

    move-result-object v0

    invoke-static {}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->access$200()J

    move-result-wide v2

    invoke-virtual {v0, p0, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$5;->val$resendButton:Landroid/widget/Button;

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setEnabled(Z)V

    return-void

    :cond_1
    iget-object v0, p0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$5;->val$resendButton:Landroid/widget/Button;

    sget v1, Lcom/facebook/accountkit/R$string;->com_accountkit_button_resend_sms:I

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(I)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$5;->val$resendButton:Landroid/widget/Button;

    invoke-virtual {v0, v2}, Landroid/widget/Button;->setEnabled(Z)V

    return-void
.end method
